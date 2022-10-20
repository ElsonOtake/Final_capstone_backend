class Api::V1::GaleriesController < ApplicationController
  def index
    vehicle = Vehicle.find_by_id!(params[:vehicle_id])
    galeries = vehicle.galeries
    render json: galeries
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end

  def create; end
end
