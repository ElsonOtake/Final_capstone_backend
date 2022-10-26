class Api::V1::GalleriesController < ApplicationController
  load_and_authorize_resource
  before_action :authorize_request

  ALLOWED_DATA = %(photo).freeze

  def index
    vehicle = Vehicle.find_by_id!(params[:vehicle_id])
    galleries = vehicle.galleries
    render json: galleries, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end

  def create
    data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
    return render json: { error: 'Empty body. Could not create gallery.' }, status: :unprocessable_entity if data.empty?

    vehicle = Vehicle.find(params[:vehicle_id])
    gallery = vehicle.galleries.new(data)
    if gallery.save
      render json: gallery, status: :ok
    else
      render json: { error: 'Could not create gallery.' }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end
end
