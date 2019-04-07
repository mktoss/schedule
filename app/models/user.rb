class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :project_users
  has_many :projects, through: :project_users
  has_many :my_project, foreign_key: 'owner_id', class_name: 'Project'

  validates :name, presence: true, uniqueness: true, length: { maximum: 12 }

  scope :remove_current_user, -> current_user { where.not(id: current_user) }
  scope :remove_member, -> user_ids { where.not(id: user_ids) }
  scope :search_user, -> keyword { where(name: keyword) }
end
