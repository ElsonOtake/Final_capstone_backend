class Booking < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :vehicle
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :end_date, comparison: { greater_than: :start_date }
  validates :city, presence: true
end
