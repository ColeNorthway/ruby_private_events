class UserProfile < ApplicationRecord
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :users
end
