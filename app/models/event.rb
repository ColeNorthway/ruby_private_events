class Event < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :date, presence: true
  validates :location, presence: true

  # The event creator
  #   - Works
  belongs_to :host, class_name: "User"

  # Has many event attendees
  #   - Attendees are through a join table called "event_attendances"
  has_many :event_attendances, foreign_key: :event_id
  has_many :attendees, through: :event_attendances
end
