class Api::V1::GalleriesController < ApplicationController
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
    if current_user.is? :admin
      data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
      return render json: { error: 'Empty body. Could not create gallery.' }, status: :unprocessable_entity unless data

      vehicle = Vehicle.find(params[:vehicle_id])
      gallery = vehicle.galleries.new(data)
      if gallery.save
        render json: gallery, status: :ok
      else
        render json: { error: 'Could not create gallery.' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized.' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end
end
