require 'swagger_helper'

RSpec.describe 'api', type: :request do
  path '/api/signup' do
    post 'Signs up a user' do
      tags 'Sign Up'
      consumes 'application/json'
      parameter name: :signup, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '201', 'user created' do
        let(:signup) { { email: 'test1@test.test', password: 'password' } }
        run_test!
      end

      response '400', 'invalid request' do
        let(:signup) { { email: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/login' do
    post 'Logs in a user' do
      tags 'Login'
      consumes 'application/json'
      parameter name: :login, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'user logged in' do
        User.new(email: 'test2@test.test', password: 'password').save
        let(:login) { { email: 'test2@test.test', password: 'password' } }
        run_test!
      end

      response '422', 'invalid credentials' do
        let(:login) { { email: 'foo' } }
        run_test!
      end

      response '422', 'invalid credentials' do
        let(:login) { { email: 'test2@test.test', password: 'passwor' } }
        run_test!
      end
    end
  end
end
