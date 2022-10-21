class Vehicle < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :galleries, dependent: :destroy
  validates :model, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
