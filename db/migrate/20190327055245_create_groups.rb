class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false, default: "名無しのスケジュール"
      t.timestamps
    end
  end
end
