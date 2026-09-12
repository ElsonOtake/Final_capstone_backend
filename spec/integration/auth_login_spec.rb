require 'swagger_helper'

describe 'Auth login' do
  path '/api/v1/auth/login' do
    post 'Login user' do
      tags 'Login'
      description 'Login user with valid authorization'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, description: 'User validation', schema: {
        type: :object,
        properties: {
          name: { type: :string },
          password: { type: :string }
        },
        required: %w[name password]
      }

      response '200', 'OK' do
        let(:user) do
          User.create(name: 'Elson Otake', email: 'elson.otake@example.com', password: 'password123')
          { name: 'Elson Otake', password: 'password123' }
        end
        run_test!
      end

      response '401', 'Unauthorized' do
        description 'Returned for both to avoid revealing which one was wrong'
        let(:user) { { name: 'nonexistent-user', password: 'wrong-password' } }
        run_test!
      end
    end
  end
end
