class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :project_users
  has_many :projects, through: :project_users

  validates :name, presence: true, uniqueness: true

  scope :remove_current_user, -> current_user { where.not(id: current_user) }
  scope :remove_member, -> user_ids { where.not(id: user_ids) }
  scope :get_user, -> keyword { where(name: keyword) }
end
