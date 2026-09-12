require 'swagger_helper'

describe 'Galleries' do
  before(:each) do
    @user = User.create(name: 'booking_user', email: 'booking_user@example.com', password: 'password123', role: 'admin')
    post '/api/v1/auth/login', params: { name: 'booking_user', password: 'password123' }.to_json
    @token = JSON.parse(response.body).with_indifferent_access[:token]

    @vehicle = Vehicle.create(model: 'foo', price: 100)
  end

  path '/api/v1/vehicles/{vehicle_id}/galleries' do
    get 'Retrieves galleries' do
      security [{ ApiKeyAuth: [] }]
      tags 'Galleries'
      description 'Retrieves all galleries'
      produces 'application/json'
      parameter name: :vehicle_id, in: :path, type: :integer, required: true, description: 'Vehicle identification'

      response '200', 'OK' do
        schema type: :array, items: {
          type: :object, properties: {
                           id: { type: :integer },
                           photo: { type: :string },
                           vehicle: { type: :object }
                         },
          required: %w[photo vehicle]
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

  path '/api/v1/vehicles/{vehicle_id}/galleries' do
    post 'Creates a gallery' do
      security [{ ApiKeyAuth: [] }]
      tags 'Galleries'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :vehicle_id, in: :path, type: :integer, required: true, description: 'Vehicle identification'
      parameter name: :id, in: :body, required: true, description: 'Gallery data', schema: {
        type: :object, properties: {
                         photo: { type: :string },
                         user_id: { type: :integer }
                       },
        required: %w[photo user_id]
      }

      response '200', 'OK' do
        let(:vehicle_id) { @vehicle.id }
        let(:id) { { photo: 'foo.jpg', user_id: @user.id } }
        let(:Authorization) { @token }
        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:vehicle_id) { @vehicle.id }
        let(:id) { { user_id: @user.id } }
        let(:Authorization) { @token }
        run_test!
      end
    end
  end
end
