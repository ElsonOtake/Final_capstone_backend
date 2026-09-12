require 'swagger_helper'

describe 'Vehicles' do
  before(:each) do
    @user = User.create(name: 'booking_user', email: 'booking_user@example.com', password: 'password123', role: 'admin')
    post '/api/v1/auth/login', params: { name: 'booking_user', password: 'password123' }.to_json
    @token = JSON.parse(response.body).with_indifferent_access[:token]

    @vehicle = Vehicle.create(model: 'foo', price: 100)
  end

  path '/api/v1/vehicles' do
    get 'List vehicles' do
      security [{ ApiKeyAuth: [] }]
      tags 'Vehicles'
      description 'Retrieves all vehicles'
      produces 'application/json'

      response '200', 'OK' do
        schema type: :array, items: {
          type: :object, properties: {
                           id: { type: :integer },
                           model: { type: :string },
                           description: { type: %i[string null] },
                           year: { type: %i[string null] },
                           brand: { type: %i[string null] },
                           color: { type: %i[string null] },
                           country: { type: %i[string null] },
                           power: { type: %i[string null] },
                           max_speed: { type: %i[string null] },
                           acceleration: { type: %i[string null] },
                           price: { type: :integer },
                           created_at: { type: :string },
                           updated_at: { type: :string }
                         },
          required: %w[id model price created_at updated_at]
        }
        let(:Authorization) { @token }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { nil }
        run_test!
      end
    end
  end

  path '/api/v1/vehicles/{id}' do
    get 'Retrieve a vehicle' do
      security [{ ApiKeyAuth: [] }]
      tags 'Vehicles'
      description 'Retrieves a vehicle'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true, description: 'Vehicle identification'

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :integer }, model: { type: :string }, description: { type: %i[string null] },
                 year: { type: %i[string null] }, brand: { type: %i[string null] }, color: { type: %i[string null] },
                 country: { type: %i[string null] }, power: { type: %i[string null] }, max_speed: { type: %i[string null] },
                 acceleration: { type: %i[string null] }, price: { type: :integer },
                 created_at: { type: :string }, updated_at: { type: :string }
               },
               required: %w[model price]

        let(:id) { @vehicle.id }
        let(:Authorization) { @token }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:id) { @vehicle.id }
        let(:Authorization) { nil }
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { 999_999 }
        let(:Authorization) { @token }
        run_test!
      end
    end
  end

  path '/api/v1/vehicles' do
    post 'Create a vehicle' do
      security [{ ApiKeyAuth: [] }]
      tags 'Vehicles'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :vehicle, in: :body, description: 'Create a vehicle', schema: {
        type: :object,
        properties: {
          model: { type: :string },
          description: { type: %i[string null] },
          year: { type: %i[string null] },
          brand: { type: %i[string null] },
          color: { type: %i[string null] },
          country: { type: %i[string null] },
          power: { type: %i[string null] },
          max_speed: { type: %i[string null] },
          acceleration: { type: %i[string null] },
          price: { type: :integer },
          user_id: { type: :integer }
        },
        required: %w[model price user_id]
      }

      response '200', 'OK' do
        let(:vehicle) { { model: 'Fusca', price: 15, user_id: @user.id } }
        let(:Authorization) { @token }
        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:vehicle) { { model: 'Fusca', user_id: @user.id } }
        let(:Authorization) { @token }
        run_test!
      end
    end
  end

  path '/api/v1/vehicles/{id}' do
    delete 'Delete a vehicle' do
      security [{ ApiKeyAuth: [] }]
      tags 'Vehicles'
      description 'Delete a vehicle'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true, description: 'Vehicle identification'

      response '200', 'OK' do
        schema type: :object, properties: {
                                id: { type: :integer },
                                model: { type: :string },
                                description: { type: %i[string null] },
                                year: { type: %i[string null] },
                                brand: { type: %i[string null] },
                                color: { type: %i[string null] },
                                country: { type: %i[string null] },
                                power: { type: %i[string null] },
                                max_speed: { type: %i[string null] },
                                acceleration: { type: %i[string null] },
                                price: { type: :integer },
                                created_at: { type: :string },
                                updated_at: { type: :string }
                              },
               required: %w[model price]

        let(:id) { @vehicle.id }
        let(:Authorization) { @token }
        run_test!
      end
    end
  end
end
