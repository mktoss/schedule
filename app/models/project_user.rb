class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user

  scope :get_current_user, -> user_id { where(user_id: user_id) }
  scope :get_current_project, -> project_id { where(project_id: project_id) }
end
