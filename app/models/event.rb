class Event < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :date, presence: true
  validates :location, presence: true

  belongs_to :users
end
