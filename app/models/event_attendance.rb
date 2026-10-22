class EventAttendance < ApplicationRecord
  validates :event_id, presence: true
  validates :attendee_id, presence: true
  # validates_associated :users
  # validates_associated :events
end
