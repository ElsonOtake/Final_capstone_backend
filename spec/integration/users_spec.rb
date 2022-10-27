require 'swagger_helper'

describe 'Users' do
  path '/api/v1/users' do
    get 'List users' do
      tags 'Users'
      description 'Retrieves all users'
      produces 'application/json'

      response '200', 'OK' do
        schema type: :object, properties: {
                                id: { type: :integer },
                                name: { type: :string },
                                email: { type: :string },
                                role: { type: :string },
                                created_at: { type: :string },
                                updated_at: { type: :string }
                              },
               required: %w[name email]

        let(:id) { User.create(name: 'foo', email: 'foo@bar.com', password: 'foobar').id }
        run_test!
      end
    end
  end

  path '/api/v1/users' do
    post 'Create a user' do
      security [{ ApiKeyAuth: [] }]
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, description: 'Create a user', schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          role: { type: :string }
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
                 role: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[name email]

        let(:id) { User.create(name: 'foo', email: 'foo@bar.com', password: 'foobar').id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:id) { 'Unauthorized' }
        run_test!
      end

      response '404', 'Not Found' do
        let(:id) { 'User not found' }
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
                                     role: { type: :string } },
        required: %w[name email password]
      }
      response '200', 'OK' do
        schema type: :object,
               properties: { id: { type: :integer }, name: { type: :string }, email: { type: :string },
                             role: { type: :string }, created_at: { type: :string }, updated_at: { type: :string } },
               required: %w[name email]

        let(:id) { User.create(name: 'foo', email: 'foo@bar.com', password: 'foobar').id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:id) { 'Unauthorized' }
        run_test!
      end

      response '404', 'Not Found' do
        let(:id) { 'User not found' }
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
                 role: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[name email]

        let(:id) { create(:user).id }
        run_test!
      end
    end
  end
end
