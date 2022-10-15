require 'swagger_helper'

RSpec.describe 'api', type: :request do
  path '/api/signup' do
    post 'Signs up a user' do
      tags 'Sign Up'
      consumes 'application/json'
      parameter name: :signup, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        },
        required: %w[username password]
      }

      response '201', 'user created' do
        let(:signup) { { username: 'test1@test.test', password: 'password' } }
        run_test!
      end

      response '400', 'invalid request' do
        let(:signup) { { username: 'foo' } }
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
          username: { type: :string },
          password: { type: :string }
        },
        required: %w[username password]
      }

      response '200', 'user logged in' do
        User.new(username: 'test2@test.test', password: 'password').save
        let(:login) { { username: 'test2@test.test', password: 'password' } }
        run_test!
      end

      response '422', 'invalid credentials' do
        let(:login) { { username: 'foo' } }
        run_test!
      end

      response '422', 'invalid credentials' do
        let(:login) { { username: 'test2@test.test', password: 'passwor' } }
        run_test!
      end
    end
  end
end
