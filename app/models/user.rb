class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_associated :user_profile
  validates_associated :created_events
  validates_associated :event_attendances
  validates_associated :attended_events

  # User signup information like locale and personal info
  has_one :user_profile

  # Has many created events
  #   - Works
  has_many :created_events, foreign_key: :host_id, class_name: "Event", dependent: :destroy

  # Has many attended events
  #   - Attended events are through a join table called "event_attendances"
  has_many :event_attendances, foreign_key: :attendee_id, dependent: :destroy
  has_many :attended_events, through: :event_attendances, source: :event
end
