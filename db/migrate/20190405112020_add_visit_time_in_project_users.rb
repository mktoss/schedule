class AddVisitTimeInProjectUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :project_users, :visit_time, :datetime
  end
end
