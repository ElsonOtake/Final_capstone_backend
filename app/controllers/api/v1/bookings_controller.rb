class Api::V1::BookingsController < ApplicationController
  # load_and_authorize_resource
  before_action :authorize_request

  ALLOWED_DATA = %(user_id vehicle_id start_date end_date city).freeze

  def index_vehicle
    vehicle = Vehicle.find_by_id!(params[:vehicle_id])
    bookings = vehicle.bookings
    render json: bookings, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end

  def index_user
    user = User.find_by_id!(params[:user_id])
    bookings = user.bookings
    render json: bookings, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def index
    # puts "***** booking index #{current_user}"
    params.include?('vehicle_id') ? index_vehicle : index_user
  end

  def show_vehicle
    vehicle = Vehicle.find_by_id!(params[:vehicle_id])
    booking = vehicle.bookings.find_by_id!(params[:id])
    render json: booking, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle/Booking not found' }, status: :not_found
  end

  def show_user
    user = User.find_by_id!(params[:user_id])
    booking = user.bookings.find_by_id!(params[:id])
    render json: booking, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User/Booking not found' }, status: :not_found
  end

  def show
    # puts "***** booking show #{current_user}"
    params.include?('vehicle_id') ? show_vehicle : show_user
  end

  def create_vehicle_booking
    vehicle = Vehicle.find(params[:vehicle_id])
    booking = vehicle.bookings.new(@data)
    if booking.save
      render json: booking, status: :ok
    else
      render json: { error: 'Could not create booking.' }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end

  def create_user_booking
    user = User.find(params[:user_id])
    booking = user.bookings.new(@data)
    if booking.save
      render json: booking, status: :ok
    else
      render json: { error: 'Could not create booking.' }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def create
    # puts "***** bookings create #{current_user}"
    @data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
    if @data.empty?
      return render json: { error: 'Empty body. Could not create booking.' },
                    status: :unprocessable_entity
    end
    @data.include?('vehicle_id') ? create_user_booking : create_vehicle_booking
  end
end
