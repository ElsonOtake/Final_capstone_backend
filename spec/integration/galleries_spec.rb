require 'swagger_helper'

describe 'Galleries' do
  before(:each) do
    @user = User.create(name: 'booking_user', email: 'booking_user@example.com', password: 'password123')
    post '/api/v1/auth/login', params: { name: 'booking_user', password: 'password123' }.to_json
    @token = JSON.parse(response.body).with_indifferent_access[:token]

    @admin = User.create(name: 'gallery_admin', email: 'gallery_admin@example.com', password: 'password123',
                         role: 'admin')
    post '/api/v1/auth/login', params: { name: 'gallery_admin', password: 'password123' }.to_json
    @admin_token = JSON.parse(response.body).with_indifferent_access[:token]

    @vehicle = Vehicle.create(model: 'foo', price: 100)
    @vehicle.galleries.create(photo: 'existing.png')
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
      parameter name: :gallery, in: :body, required: true, description: 'Gallery data', schema: {
        type: :object, properties: {
                         photo: { type: :string }
                       },
        required: %w[photo]
      }

      response '200', 'OK' do
        let(:vehicle_id) { @vehicle.id }
        let(:gallery) { { photo: 'foo.jpg' } }
        let(:Authorization) { @admin_token }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:vehicle_id) { @vehicle.id }
        let(:gallery) { { photo: 'foo.jpg' } }
        let(:Authorization) { @token }
        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:vehicle_id) { @vehicle.id }
        let(:gallery) { {} }
        let(:Authorization) { @admin_token }
        run_test!
      end
    end
  end
end
