class AddTodoInEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :todo, :boolean, null: false, default: false
  end
end
