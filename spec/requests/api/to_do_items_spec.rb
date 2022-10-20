require 'swagger_helper'
require 'jwt'

RSpec.describe 'api/to_do_items', type: :request do
  path '/api/todo_items' do
    post 'Creates a todo item' do
      tags 'Todo Items'
      security [bearer: []]
      consumes 'application/json'
      parameter name: :todo_item, in: :body, schema: {
        type: :object,
        properties: {
          task: { type: :string },
          date: { type: :string },
          time: { type: :string },
          priority: { type: :integer },
          completed: { type: :boolean }
        }
      }

      response '200', 'todo item created' do
        payload = { user_data: 1, exp: 24.hours.from_now.to_i }
        let(:Authorization) { "Bearer #{JWT.encode payload, ENV['ENCODING_SECRET'], 'HS256'}" }
        let(:todo_item) do
          { task: 'Task', date: '2021-01-01', time: '00:00', priority: 1, completed: false }
        end
        run_test!
      end

      response '200', 'empty todo item created' do
        payload = { user_data: 213, exp: 24.hours.from_now.to_i }
        let(:Authorization) { "Bearer #{JWT.encode payload, ENV['ENCODING_SECRET'], 'HS256'}" }
        let(:todo_item) { {} }
        run_test!
      end

      response '422', 'invalid auth token' do
        payload = { user_data: 1, exp: 24.hours.from_now.to_i }
        let(:Authorization) { "Bearer error#{JWT.encode payload, ENV['ENCODING_SECRET'], 'HS256'}" }
        let(:todo_item) do
          { task: 'Task', date: '2021-01-01', time: '00:00', priority: 1, completed: false }
        end
        run_test!
      end
    end

    get 'Retrieves all todo items for user' do
      tags 'Todo Items'
      security [bearer: []]
      consumes 'application/json'

      response '200', 'todo items retrieved' do
        payload = { user_data: 1, exp: 24.hours.from_now.to_i }
        let(:Authorization) { "Bearer #{JWT.encode payload, ENV['ENCODING_SECRET'], 'HS256'}" }
        run_test!
      end
    end
  end

  path '/api/todo_items/{id}' do
    put 'Updates a todo item' do
      tags 'Todo Items'
      security [bearer: []]
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :todo_item, in: :body, schema: {
        type: :object,
        properties: {
          task: { type: :string },
          date: { type: :string },
          time: { type: :string },
          priority: { type: :integer },
          completed: { type: :boolean }
        }
      }

      response '200', 'todo item updated' do
        payload = { user_data: 1, exp: 24.hours.from_now.to_i }
        let(:Authorization) { "Bearer #{JWT.encode payload, ENV['ENCODING_SECRET'], 'HS256'}" }
        todo = TodoItem.create(task: 'Task', date: '2021-01-01', time: '00:00', priority: 1, completed: false,
                               user_id: 1)
        let(:id) { todo.id }
        let(:todo_item) do
          { task: 'Task', date: '2021-01-01', time: '00:00', priority: 1, completed: false }
        end
        run_test!
      end

      response '404', 'todo item not found' do
        payload = { user_data: 1, exp: 24.hours.from_now.to_i }
        let(:Authorization) { "Bearer #{JWT.encode payload, ENV['ENCODING_SECRET'], 'HS256'}" }
        let(:id) { 2_342_346_435 }
        let(:todo_item) do
          { task: 'Task', date: '2021-01-01', time: '00:00', priority: 1, completed: false }
        end
        run_test!
      end
    end

    patch 'Updates a todo item' do
      tags 'Todo Items'
      security [bearer: []]
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :todo_item, in: :body, schema: {
        type: :object,
        properties: {
          task: { type: :string },
          date: { type: :string },
          time: { type: :string },
          priority: { type: :integer },
          completed: { type: :boolean }
        }
      }

      response '200', 'todo item updated' do
        payload = { user_data: 1, exp: 24.hours.from_now.to_i }
        let(:Authorization) { "Bearer #{JWT.encode payload, ENV['ENCODING_SECRET'], 'HS256'}" }
        todo = TodoItem.create(task: 'Task', date: '2021-01-01', time: '00:00', priority: 1, completed: false,
                               user_id: 1)
        let(:id) { todo.id }
        let(:todo_item) do
          { task: 'Task Updated', completed: true }
        end
        run_test!
      end

      response '404', 'todo item not found' do
        payload = { user_data: 1, exp: 24.hours.from_now.to_i }
        let(:Authorization) { "Bearer #{JWT.encode payload, ENV['ENCODING_SECRET'], 'HS256'}" }
        let(:id) { 2_342_346_435 }
        let(:todo_item) do
          { task: 'Task Updated', completed: true }
        end
        run_test!
      end
    end

    delete 'Deletes a todo item' do
      tags 'Todo Items'
      security [bearer: []]
      parameter name: :id, in: :path, type: :integer

      response '200', 'todo item deleted' do
        payload = { user_data: 1, exp: 24.hours.from_now.to_i }
        let(:Authorization) { "Bearer #{JWT.encode payload, ENV['ENCODING_SECRET'], 'HS256'}" }
        todo = TodoItem.create(task: 'Task', date: '2021-01-01', time: '00:00', priority: 1, completed: false,
                               user_id: 1)
        let(:id) { todo.id }
        run_test!
      end

      response '404', 'todo item not found' do
        payload = { user_data: 1, exp: 24.hours.from_now.to_i }
        let(:Authorization) { "Bearer #{JWT.encode payload, ENV['ENCODING_SECRET'], 'HS256'}" }
        let(:id) { 2_342_346_435 }
        run_test!
      end
    end
  end
end
