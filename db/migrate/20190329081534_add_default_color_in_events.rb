class AddDefaultColorInEvents < ActiveRecord::Migration[5.2]
  def up
    change_column :events, :color, :integer, default: 0
  end

  def down
    change_column :events, :color, :integer
  end
end
