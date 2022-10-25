class Api::V1::BookingsController < ApplicationController
  # load_and_authorize_resource
  before_action :authorize_request

  ALLOWED_DATA = %(user_id vehicle_id start_date end_date city).freeze

  def index_vehicle
    vehicle = Vehicle.find_by_id!(params[:vehicle_id])
    bookings = vehicle.bookings
    render json: bookings
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end

  def index_user
    user = User.find_by_id!(params[:user_id])
    bookings = user.bookings
    render json: bookings
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def index
    index_vehicle if params.include?('vehicle_id')
    index_user if params.include?('user_id')
  end

  def show_vehicle
    vehicle = Vehicle.find_by_id!(params[:vehicle_id])
    booking = vehicle.bookings.find_by_id!(params[:id])
    render json: booking
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle/Booking not found' }, status: :not_found
  end

  def show_user
    user = User.find_by_id!(params[:user_id])
    booking = user.bookings.find_by_id!(params[:id])
    render json: booking
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User/Booking not found' }, status: :not_found
  end

  def show
    show_vehicle if params.include?('vehicle_id')
    show_user if params.include?('user_id')
  end

  def create_vehicle_booking
    vehicle = Vehicle.find(params[:vehicle_id])
    booking = vehicle.bookings.new(@data)
    if booking.save
      render json: booking
    else
      render json: { error: 'Could not create booking.' }
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end

  def create_user_booking
    user = User.find(params[:user_id])
    booking = user.bookings.new(@data)
    if booking.save
      render json: booking
    else
      render json: { error: 'Could not create booking.' }
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def create
    @data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
    return render json: { error: 'Empty body. Could not create booking.' } if @data.empty?

    create_vehicle_booking if params.include?('vehicle_id')
    create_user_booking if params.include?('user_id')
  end
end
