class Api::V1::GaleriesController < ApplicationController
  # before_action :authorize_request

  ALLOWED_DATA = %(photo).freeze

  def index
    vehicle = Vehicle.find_by_id!(params[:vehicle_id])
    galeries = vehicle.galeries
    render json: galeries
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end

  def create
    data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
    return render json: { error: 'Empty body. Could not create galery.' } if data.empty?

    vehicle = Vehicle.find(params[:vehicle_id])
    galery = vehicle.galeries.new(data)
    if galery.save
      render json: galery
    else
      render json: { error: 'Could not create galery.' }
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end
end
