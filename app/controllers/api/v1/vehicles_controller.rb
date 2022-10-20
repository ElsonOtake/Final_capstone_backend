class Api::V1::VehiclesController < ApplicationController
  ALLOWED_DATA = %(model year brand color country power max_speed acceleration info_interior info_exterior price).freeze

  def index
    vehicles = Vehicle.all
    render json: vehicles
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicles not found' }, status: :not_found
  end

  def show
    vehicle = Vehicle.find_by_id!(params[:id])
    render json: vehicle
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end

  def create
    data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
    return render json: { error: 'Empty body. Could not create vehicle.' } if data.empty?

    vehicle = Vehicle.new(data)
    if vehicle.save
      render json: vehicle
    else
      render json: { error: 'Could not create vehicle.' }
    end
  end
end
