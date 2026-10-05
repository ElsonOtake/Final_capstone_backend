require 'swagger_helper'

describe 'Auth login' do
  path '/api/v1/auth/login' do # rubocop:disable Metrics/BlockLength
    post 'Login user' do # rubocop:disable Metrics/BlockLength
      tags 'Login'
      description 'Login user with valid authorization'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, description: 'User validation', schema: {
        type: :object, required: %w[email password],
        properties: { email: { type: :string, format: :email }, password: { type: :string } }
      }

      response '200', 'OK' do
        let(:user) do
          User.create(name: 'Elson Otake', email: 'elson.otake@example.com', password: 'password123')
          { email: 'elson.otake@example.com', password: 'password123' }
        end
        run_test!
      end

      response '200', 'OK' do
        context 'with a case-insensitive email' do
          let(:user) do
            User.create(name: 'Elson Otake', email: 'elson.otake@example.com', password: 'password123')
            { email: 'ELSON.OTAKE@EXAMPLE.COM', password: 'password123' }
          end
          run_test!
        end
      end

      response '401', 'Unauthorized' do
        description 'Returned for both to avoid revealing which one was wrong'
        let(:user) { { email: 'nonexistent@user.com', password: 'wrong-password' } }
        run_test!
      end
    end
  end
end
