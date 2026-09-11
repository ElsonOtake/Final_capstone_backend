class Booking < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :vehicle
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :city, presence: true
end
