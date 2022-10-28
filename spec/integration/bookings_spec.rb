require 'swagger_helper'

describe 'Bookings' do
  path '/api/v1/vehicles/{vehicle_id}/bookings' do
    get 'Retrieves bookings' do
      security [{ ApiKeyAuth: [] }]
      tags 'Bookings'
      description 'Retrieves all bookings'
      produces 'application/json'
      parameter name: :vehicle_id, in: :path, type: :integer, required: true, description: 'Vehicle identification'

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

        let(:vehicle_id) { Vehicle.create(model: 'foo', price: 100).id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:vehicle_id) { 'Unauthorized' }
        run_test!
      end

      response '404', 'Not found' do
        let(:vehicle_id) { 'Vehicle not found' }
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

        let(:id) { Booking.create(start_date: '2022-10-02', end_date: '2022-11-14', city: 'Rome', user_id: 1).id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:id) { 'Unauthorized' }
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { 'Booking not found' }
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
        let(:booking) { { start_date: '2022-10-02', end_date: '2022-11-14', city: 'Rome', user_id: 1 } }
        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:booking) { { city: 'Rome' } }
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

        let(:user_id) { User.create(name: 'Ariel', email: 'ariel@capstone.com', password: 'password').id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:user_id) { 'Unauthorized' }
        run_test!
      end

      response '404', 'Not found' do
        let(:user_id) { 'User not found' }
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

        let(:id) { Booking.create(start_date: '2022-10-02', end_date: '2022-11-14', city: 'Rome', user_id: 1).id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:id) { 'Unauthorized' }
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { 'Booking not found' }
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
        let(:booking) { { start_date: '2022-10-02', end_date: '2022-11-14', city: 'Rome', vehicle_id: 1 } }
        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:booking) { { city: 'Rome' } }
        run_test!
      end
    end
  end
end
