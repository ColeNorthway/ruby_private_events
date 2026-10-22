class EventAttendance < ApplicationRecord
  validates :event_id, presence: true
  validates :attendee_id, presence: true

  belongs_to :attendee, class_name: "User"
  belongs_to :event
end
