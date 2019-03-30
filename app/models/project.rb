class Project < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users

  validates :name, presence: true, length: { maximum: 15 }
end
