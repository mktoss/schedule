class RenameColorInEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :color, :bar_color
  end
end
