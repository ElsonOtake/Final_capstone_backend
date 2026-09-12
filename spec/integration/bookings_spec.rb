require 'swagger_helper'

describe 'Bookings' do
  before(:each) do
    @user = User.create(name: 'booking_user', email: 'booking_user@example.com', password: 'password123')
    post '/api/v1/auth/login', params: { name: 'booking_user', password: 'password123' }.to_json
    @token = JSON.parse(response.body).with_indifferent_access[:token]

    @vehicle = Vehicle.create(model: 'foo', price: 100)
    @booking = @vehicle.bookings.create(start_date: '2022-10-02', end_date: '2022-11-14', city: 'Rome',
                                        user_id: @user.id)
  end

  path '/api/v1/vehicles/{vehicle_id}/bookings' do
    get 'Retrieves bookings' do
      security [{ ApiKeyAuth: [] }]
      tags 'Bookings'
      description 'Retrieves all bookings'
      produces 'application/json'
      parameter name: :vehicle_id, in: :path, type: :integer, required: true, description: 'Vehicle identification'

      response '200', 'OK' do
        schema type: :array, items: {
          type: :object, properties: {
                           id: { type: :integer },
                           start_date: { type: :string },
                           end_date: { type: :string },
                           city: { type: :string },
                           vehicle_id: { type: :integer },
                           user_id: { type: :integer },
                           created_at: { type: :string },
                           updated_at: { type: :string }
                         },
          required: %w[start_date end_date city vehicle_id user_id]
        }

        let(:vehicle_id) { @vehicle.id }
        let(:Authorization) { @token }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:vehicle_id) { @vehicle.id }
        let(:Authorization) { nil }
        run_test!
      end

      response '404', 'Not found' do
        let(:vehicle_id) { 999_999 }
        let(:Authorization) { @token }
        run_test!
      end
    end
  end

  path '/api/v1/vehicles/{vehicle_id}/bookings/{id}' do
    get 'Retrieve a booking' do
      security [{ ApiKeyAuth: [] }]
      tags 'Bookings'
      produces 'application/json'
      parameter name: :vehicle_id, in: :path, type: :integer, required: true, description: 'Vehicle identification'
      parameter name: :id, in: :path, type: :integer, required: true, description: 'Booking identification'

      response '200', 'OK' do
        schema type: :object, properties: {
                                id: { type: :integer },
                                start_date: { type: :string },
                                end_date: { type: :string },
                                city: { type: :string },
                                vehicle_id: { type: :integer },
                                user_id: { type: :integer },
                                created_at: { type: :string },
                                updated_at: { type: :string }
                              },
               required: %w[start_date end_date city vehicle_id user_id]

        let(:vehicle_id) { @vehicle.id }
        let(:id) { @booking.id }
        let(:Authorization) { @token }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:vehicle_id) { @vehicle.id }
        let(:id) { @booking.id }
        let(:Authorization) { nil }
        run_test!
      end

      response '404', 'Not found' do
        let(:vehicle_id) { @vehicle.id }
        let(:id) { 999_999 }
        let(:Authorization) { @token }
        run_test!
      end
    end
  end

  path '/api/v1/vehicles/{vehicle_id}/bookings' do
    post 'Create a booking' do
      security [{ ApiKeyAuth: [] }]
      tags 'Bookings'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :vehicle_id, in: :path, type: :integer, required: true, description: 'Vehicle identification'
      parameter name: :booking, in: :body, description: 'Create a booking', schema: {
        type: :object,
        properties: {
          start_date: { type: :string },
          end_date: { type: :string },
          city: { type: :string },
          user_id: { type: :integer }
        },
        required: %w[start_date end_date city user_id]
      }

      response '200', 'OK' do
        let(:vehicle_id) { @vehicle.id }
        let(:booking) { { start_date: '2022-12-01', end_date: '2022-12-05', city: 'Rome', user_id: @user.id } }
        let(:Authorization) { @token }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:vehicle_id) { @vehicle.id }
        let(:booking) { { start_date: '2022-12-01', end_date: '2022-12-05', city: 'Rome', user_id: @user.id } }
        let(:Authorization) { nil }
        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:vehicle_id) { @vehicle.id }
        let(:booking) { { city: 'Rome' } }
        let(:Authorization) { @token }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/bookings' do
    get 'Retrieves bookings' do
      security [{ ApiKeyAuth: [] }]
      tags 'Bookings'
      description 'Retrieves all bookings'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer, required: true, description: 'User identification'

      response '200', 'OK' do
        schema type: :array, items: {
          type: :object, properties: {
                           id: { type: :integer },
                           start_date: { type: :string },
                           end_date: { type: :string },
                           city: { type: :string },
                           vehicle_id: { type: :integer },
                           user_id: { type: :integer },
                           created_at: { type: :string },
                           updated_at: { type: :string }
                         },
          required: %w[start_date end_date city vehicle_id user_id]
        }

        let(:user_id) { @user.id }
        let(:Authorization) { @token }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:user_id) { @user.id }
        let(:Authorization) { nil }
        run_test!
      end

      response '404', 'Not found' do
        let(:user_id) { 999_999 }
        let(:Authorization) { @token }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/bookings/{id}' do
    get 'Retrieve a booking' do
      security [{ ApiKeyAuth: [] }]
      tags 'Bookings'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer, required: true, description: 'User identification'
      parameter name: :id, in: :path, type: :integer, required: true, description: 'Booking identification'

      response '200', 'OK' do
        schema type: :object, properties: {
                                id: { type: :integer },
                                start_date: { type: :string },
                                end_date: { type: :string },
                                city: { type: :string },
                                vehicle_id: { type: :integer },
                                user_id: { type: :integer },
                                created_at: { type: :string },
                                updated_at: { type: :string }
                              },
               required: %w[start_date end_date city vehicle_id user_id]

        let(:user_id) { @user.id }
        let(:id) { @booking.id }
        let(:Authorization) { @token }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:user_id) { @user.id }
        let(:id) { @booking.id }
        let(:Authorization) { nil }
        run_test!
      end

      response '404', 'Not found' do
        let(:user_id) { @user.id }
        let(:id) { 999_999 }
        let(:Authorization) { @token }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/bookings' do
    post 'Create a booking' do
      security [{ ApiKeyAuth: [] }]
      tags 'Bookings'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer, required: true, description: 'User identification'
      parameter name: :booking, in: :body, description: 'Create a booking', schema: {
        type: :object,
        properties: {
          start_date: { type: :string },
          end_date: { type: :string },
          city: { type: :string },
          vehicle_id: { type: :integer }
        },
        required: %w[start_date end_date city vehicle_id]
      }

      response '200', 'OK' do
        let(:user_id) { @user.id }
        let(:booking) { { start_date: '2022-12-10', end_date: '2022-12-15', city: 'Rome', vehicle_id: @vehicle.id } }
        let(:Authorization) { @token }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:user_id) { @user.id }
        let(:booking) { { start_date: '2022-12-10', end_date: '2022-12-15', city: 'Rome', vehicle_id: @vehicle.id } }
        let(:Authorization) { nil }
        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:user_id) { @user.id }
        let(:booking) { { city: 'Rome' } }
        let(:Authorization) { @token }
        run_test!
      end
    end
  end
end
