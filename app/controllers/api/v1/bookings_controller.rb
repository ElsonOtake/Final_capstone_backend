class Api::V1::BookingsController < ApplicationController
  before_action :authorize_request

  ALLOWED_DATA = %w[user_id vehicle_id start_date end_date city].freeze

  def index_vehicle
    vehicle = Vehicle.find_by_id!(params[:vehicle_id])
    bookings = vehicle.bookings
    render json: bookings, status: :ok
  end

  def index_user
    user = User.find_by_id!(params[:user_id])
    bookings = user.bookings
    render json: bookings, status: :ok
  end

  def index
    params.include?('vehicle_id') ? index_vehicle : index_user
  end

  def show_vehicle
    vehicle = Vehicle.find_by_id!(params[:vehicle_id])
    booking = vehicle.bookings.find_by_id!(params[:id])
    render json: booking, status: :ok
  end

  def show_user
    user = User.find_by_id!(params[:user_id])
    booking = user.bookings.find_by_id!(params[:id])
    render json: booking, status: :ok
  end

  def show
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
  end

  def create_user_booking
    user = User.find(params[:user_id])
    booking = user.bookings.new(@data)
    if booking.save
      render json: booking, status: :ok
    else
      render json: { error: 'Could not create booking.' }, status: :unprocessable_entity
    end
  end

  def create
    @data = json_payload.slice(*ALLOWED_DATA)
    if @data.empty?
      return render json: { error: 'Empty body. Could not create booking.' },
                    status: :unprocessable_entity
    end
    if @data.include?('vehicle_id')
      create_user_booking
    elsif @data.include?('user_id')
      create_vehicle_booking
    else
      render json: { error: 'Could not create booking.' }, status: :unprocessable_entity
    end
  end
end
