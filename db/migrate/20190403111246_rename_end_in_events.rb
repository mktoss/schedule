class RenameEndInEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :end, :end_time
  end
end
