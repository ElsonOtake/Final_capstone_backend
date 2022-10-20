class Api::V1::VehiclesController < ApplicationController
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
end
