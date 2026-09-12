require 'swagger_helper'

describe 'Users' do
  before(:each) do
    @user = User.create(name: 'plain_user', email: 'plain_user@example.com', password: 'password123')
    post '/api/v1/auth/login', params: { name: 'plain_user', password: 'password123' }.to_json
    @token = JSON.parse(response.body).with_indifferent_access[:token]

    @admin = User.create(name: 'users_admin', email: 'users_admin@example.com', password: 'password123',
                         role: 'admin')
    post '/api/v1/auth/login', params: { name: 'users_admin', password: 'password123' }.to_json
    @admin_token = JSON.parse(response.body).with_indifferent_access[:token]
  end

  path '/api/v1/users' do
    get 'List users' do
      tags 'Users'
      description 'Retrieves all users'
      produces 'application/json'

      response '200', 'OK' do
        schema type: :array, items: {
          type: :object, properties: {
                           id: { type: :integer },
                           name: { type: :string },
                           email: { type: :string },
                           role: { type: %i[string null] },
                           created_at: { type: :string },
                           updated_at: { type: :string }
                         },
          required: %w[id name email created_at updated_at]
        }
        let(:Authorization) { @token }
        run_test!
      end
    end
  end

  path '/api/v1/users' do
    post 'Create a user' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, description: 'Create a user', schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[name email password]
      }

      response '200', 'OK' do
        let(:user) { { name: 'Ariel', email: 'ariel@capstone.com', password: 'password' } }
        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:user) { { name: 'Ariel', password: 'password' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    get 'Retrieves a user' do
      security [{ ApiKeyAuth: [] }]
      tags 'Users'
      description 'Retrieves a user'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true, description: 'User identification'

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 email: { type: :string },
                 role: { type: %i[string null] },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id name email created_at updated_at]

        let(:id) { @user.id }
        let(:Authorization) { @token }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:id) { 'Unauthorized' }
        let(:Authorization) { nil }
        run_test!
      end

      response '404', 'Not Found' do
        let(:id) { 999_999 }
        let(:Authorization) { @token }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    put 'Updates a user' do
      security [{ ApiKeyAuth: [] }]
      tags 'Users'
      description 'Updates a user'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true, description: 'User identification'
      parameter name: :user, in: :body, description: 'Updates a user', schema: {
        type: :object, properties: { name: { type: :string }, email: { type: :string }, password: { type: :string },
                                     role: { type: %i[string null] } },
        required: %w[name email password]
      }
      response '200', 'OK' do
        schema type: :object,
               properties: { id: { type: :integer }, name: { type: :string }, email: { type: :string },
                             role: { type: %i[string null] }, created_at: { type: :string }, updated_at: { type: :string } },
               required: %w[id name email created_at updated_at]

        let(:id) { @user.id }
        let(:user) { { name: 'Updated Name', email: 'updated@example.com', password: 'password123' } }
        let(:Authorization) { @admin_token }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:id) { @user.id }
        let(:user) { { name: 'Updated Name', email: 'updated@example.com', password: 'password123' } }
        let(:Authorization) { @token }
        run_test!
      end

      response '404', 'Not Found' do
        let(:id) { 999_999 }
        let(:user) { { name: 'Updated Name', email: 'updated@example.com', password: 'password123' } }
        let(:Authorization) { @admin_token }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    delete 'Delete a user' do
      security [{ ApiKeyAuth: [] }]
      tags 'Users'
      description 'Delete a user'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true, description: 'User identification'

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 email: { type: :string },
                 role: { type: %i[string null] },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[name email]

        let(:id) { User.create(name: 'to_delete', email: 'to_delete@example.com', password: 'password123').id }
        let(:Authorization) { @admin_token }
        run_test!
      end
    end
  end
end
