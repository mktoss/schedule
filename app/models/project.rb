class Project < ApplicationRecord
  has_many :events
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users

  validates :name, presence: true
end
