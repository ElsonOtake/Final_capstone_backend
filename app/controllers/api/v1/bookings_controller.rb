class Api::V1::BookingsController < ApplicationController
  def vehicle_index
    vehicle = Vehicle.find_by_id!(params[:vehicle_id])
    bookings = vehicle.bookings
    render json: bookings
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end

  def user_index
    user = User.find_by_id!(params[:user_id])
    bookings = user.bookings
    render json: bookings
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def index
    user_index if params.include?('user_id')
    vehicle_index if params.include?('vehicle_id')
  end

  def create; end
end
