class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string     :title, null: false
      t.boolean    :all_day
      t.datetime   :start
      t.datetime   :end
      t.string     :address
      t.integer    :color
      t.text       :memo
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
