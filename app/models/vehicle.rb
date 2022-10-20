class Vehicle < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :galeries, dependent: :destroy
  validates :model, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 1900 }
  validates :acceleration, numericality: { only_integer: false, greater_than_or_equal_to: 0 }
end
