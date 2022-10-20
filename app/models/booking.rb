class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle
  validates :duration, presence: true
  validates :city, presence: true
end
