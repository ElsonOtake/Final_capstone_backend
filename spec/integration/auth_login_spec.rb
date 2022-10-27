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
          { token: 'eyJhbGciOiJIUzI1NiJ9', exp: '10-27-2022 15:18', name: 'Elson Otake', role: 'admin', id: 1 }
        end
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:user) { { error: 'Unauthorized' } }
        run_test!
      end

      response '404', 'Username not found' do
        let(:user) { { error: 'Not Found' } }
        run_test!
      end
    end
  end
end
