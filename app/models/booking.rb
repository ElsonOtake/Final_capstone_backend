class Booking < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :vehicle
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :city, presence: true
  validate :end_date_after_start_date
  validate :no_overlapping_bookings

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    errors.add(:end_date, 'must be after the start date') if end_date <= start_date
  end

  def no_overlapping_bookings
    return if vehicle_id.blank? || start_date.blank? || end_date.blank?

    overlapping = Booking.where(vehicle_id: vehicle_id)
      .where.not(id: id) # exclude self when updating
      .where('start_date <= ? AND end_date >= ?', end_date, start_date)

    errors.add(:base, 'Vehicle is already booked for the selected dates') if overlapping.exists?
  end
end
