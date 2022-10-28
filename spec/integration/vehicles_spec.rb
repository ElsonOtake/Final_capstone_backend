require 'swagger_helper'

describe 'Vehicles' do
  path '/api/v1/vehicles' do
    get 'List vehicles' do
      security [{ ApiKeyAuth: [] }]
      tags 'Vehicles'
      description 'Retrieves all vehicles'
      produces 'application/json'

      response '200', 'OK' do
        schema type: :object, properties: {
                                id: { type: :integer },
                                model: { type: :string },
                                description: { type: :string },
                                year: { type: :string },
                                brand: { type: :string },
                                color: { type: :string },
                                country: { type: :string },
                                power: { type: :string },
                                max_speed: { type: :string },
                                acceleration: { type: :string },
                                price: { type: :integer },
                                created_at: { type: :string },
                                updated_at: { type: :string }
                              },
               required: %w[model price]

        let(:id) { Vehicle.create(model: 'foo', price: 100).id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:id) { 'Unauthorized' }
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
                 id: { type: :integer }, model: { type: :string }, description: { type: :string },
                 year: { type: :string }, brand: { type: :string }, color: { type: :string },
                 country: { type: :string }, power: { type: :string }, max_speed: { type: :string },
                 acceleration: { type: :string }, price: { type: :integer },
                 created_at: { type: :string }, updated_at: { type: :string }
               },
               required: %w[model price]

        let(:id) { Vehicle.create(model: 'foo', price: 100).id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:id) { 'Unauthorized' }
        run_test!
      end

      response '404', 'Not found' do
        let(:id) { 'Vehicle not found' }
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
          description: { type: :string },
          year: { type: :string },
          brand: { type: :string },
          color: { type: :string },
          country: { type: :string },
          power: { type: :string },
          max_speed: { type: :string },
          acceleration: { type: :string },
          price: { type: :integer }
        },
        required: %w[model price]
      }

      response '200', 'OK' do
        let(:vehicle) { { model: 'Fusca', price: 15 } }
        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:vehicle) { { model: 'Fusca' } }
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
                                description: { type: :string },
                                year: { type: :string },
                                brand: { type: :string },
                                color: { type: :string },
                                country: { type: :string },
                                power: { type: :string },
                                max_speed: { type: :string },
                                acceleration: { type: :string },
                                price: { type: :integer },
                                created_at: { type: :string },
                                updated_at: { type: :string }
                              },
               required: %w[model price]

        let(:id) { create(:vehicle).id }
        run_test!
      end
    end
  end
end
