class Event < ApplicationRecord
  before_save :remove_time

  belongs_to :project
  belongs_to :user

  validates :title, presence: true, length: { maximum: 12 }

  scope :get_todo, -> { where(all_day: "true").where(todo: "false") }
  scope :get_executed, -> { where(all_day: "true").where(todo: "true") }
  scope :search_event, -> keyword { where("title LIKE(?)", "#{keyword}%").order(start: "DESC") }

  enum color: [
    "#ff7f7f",
    "#ff7fbf",
    "#ff7fff",
    "#bf7fff",
    "#7f7fff",
    "#7fbfff",
    "#ffbf7f",
  ]

  def remove_time
    if self.all_day == true
      self.start = self.start.to_s.split(" ").shift
      self.end = self.end.to_s.split(" ").shift
    end
  end
end
