class CreateTodoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items do |t|
      t.string :task
      t.date :date
      t.time :time
      t.integer :priority
      t.boolean :completed
      t.integer :user_id

      t.timestamps
    end
    add_index :todo_items, :user_id
  end
end
