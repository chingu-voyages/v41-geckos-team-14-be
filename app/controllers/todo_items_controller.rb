class TodoItemsController < ApplicationController
  before_action :get_user_id
  before_action :set_todo_item, only: %i[update destroy]

  # GET /api/todo_items
  # GET /api/todo_items.json

  def index
    @todo_items = TodoItem.where(user_id: @user_id)
    render json: @todo_items
  end

  # POST /api/todo_items
  # POST /api/todo_items.json
  def create
    params[:user_id] = @user_id
    @todo_item = TodoItem.new(todo_item_params)
    if @todo_item.save
      render json: @todo_item
    else
      render json: @todo_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/todo_items/1
  # PATCH/PUT /api/todo_items/1.json
  def update
    params[:user_id] = @user_id
    unless @todo_item.user_id == @user_id
      render status: 401, json: { message: 'Todo item not found for user' }
      return
    end
    if @todo_item.update(todo_item_params)
      render json: @todo_item
    else
      render json: @todo_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/todo_items/1
  # DELETE /api/todo_items/1.json
  def destroy
    if @todo_item.user_id == @user_id
      @todo_item.destroy
      render json: { message: 'Todo item deleted' }
    else
      render json: { message: 'Todo item not found for user' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo_item
    @todo_item = TodoItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def todo_item_params
    params.permit(:task, :date, :time, :priority, :completed, :user_id)
  end

  def get_user_id
    @user_id = authenticate_user
  end
end
