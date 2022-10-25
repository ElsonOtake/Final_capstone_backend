class Api::V1::VehiclesController < ApplicationController
  # load_and_authorize_resource
  before_action :authorize_request
  before_action :find_vehicle, except: %i[create index]

  ALLOWED_DATA = %(model description year brand color country power max_speed acceleration price).freeze

  def index
    vehicles = Vehicle.all
    render json: vehicles
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicles not found' }, status: :not_found
  end

  def show
    render json: @vehicle
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

  def destroy
    @vehicle.destroy
    render json: @vehicle, status: :ok
  end

  private

  def find_vehicle
    @vehicle = Vehicle.find_by_id!(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end
end
