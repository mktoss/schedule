class ChangeAllDayInEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :all_day, :boolean, null: false, default: false
  end
end
