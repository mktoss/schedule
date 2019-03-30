class Event < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :title, presence: true, length: { maximum: 12 }

  enum color: [
    "#ff7f7f",
    "#ff7fbf",
    "#ff7fff",
    "#bf7fff",
    "#7f7fff",
    "#7fbfff",
    "#ffbf7f",
  ]
end
