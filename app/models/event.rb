class Event < ApplicationRecord
  before_save :remove_time

  belongs_to :project
  belongs_to :user

  validates :title, presence: true, length: { maximum: 12 }

  scope :get_todo, -> { where(all_day: "true").where(todo: "false") }
  scope :get_executed, -> { where(all_day: "true").where(todo: "true") }
  scope :with_keywords, -> keywords {
    if keywords.present?
      columns = [:title, :address, :memo]
      where(keywords.split(/[[:space:]]/).reject(&:empty?).map {|keyword|
        columns.map { |a| arel_table[a].matches("%#{keyword}%") }.inject(:or)
      }.inject(:and))
    end
  }

  enum bar_color: [
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
      self.end_time = self.end_time.to_s.split(" ").shift
    end
  end
end
