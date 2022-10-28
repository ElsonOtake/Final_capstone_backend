require 'swagger_helper'

describe 'Galleries' do
  path '/api/v1/vehicles/{vehicle_id}/galleries' do
    get 'Retrieves galleries' do
      security [{ ApiKeyAuth: [] }]
      tags 'Galleries'
      description 'Retrieves all galleries'
      produces 'application/json'
      parameter name: :vehicle_id, in: :path, type: :integer, required: true, description: 'Vehicle identification'

      response '200', 'OK' do
        schema type: :object, properties: {
                                id: { type: :integer },
                                photo: { type: :string },
                                vehicle_id: { type: :integer },
                                created_at: { type: :string },
                                updated_at: { type: :string }
                              },
               required: %w[photo vehicle_id]

        let(:vehicle_id) { Vehicle.create(model: 'foo', price: 100).id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:vehicle_id) { 'Unauthorized' }
        run_test!
      end

      response '404', 'Not found' do
        let(:vehicle_id) { 'Gallery not found' }
        run_test!
      end
    end
  end

  path '/api/v1/vehicles/{vehicle_id}/galleries' do
    post 'Creates a gallery' do
      security [{ ApiKeyAuth: [] }]
      tags 'Galleries'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :vehicle_id, in: :path, type: :integer, required: true, description: 'Vehicle identification'
      parameter name: :id, in: :body, required: true, description: 'Gallery data', schema: {
        type: :object, properties: {
                         photo: { type: :string }
                       },
        required: %w[photo]
      }

      response '200', 'OK' do
        let(:id) { { photo: 'foo.png', vehicle_id: 1 } }
        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:id) { { vehicle_id: 1 } }
        run_test!
      end
    end
  end
end
