class EventAttendance < ApplicationRecord
  validates :event_id, presence: true
  validates :attendee_id, presence: true
  validates_associated :attendee
  validates_associated :event

  belongs_to :attendee, class_name: "User"
  belongs_to :event
end
