class Api::V1::GalleriesController < ApplicationController
  before_action :authorize_request
  before_action :authorize_admin, only: :create
  before_action :set_vehicle

  def index
    galleries = @vehicle.galleries.map { |gallery| gallery_json(gallery) }
    render json: galleries, status: :ok
  end

  def create
    gallery = @vehicle.galleries.new

    gallery.photo_file.attach(photo_params[:photo_file])

    if gallery.save
      render json: gallery_json(gallery), status: :created
    else
      render json: { errors: gallery.errors.full_messages }, status: :unprocessable_content
    end
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end

  def authorize_admin
    return if current_user.is? :admin

    render json: { error: 'Unauthorized.' }, status: :unauthorized
  end

  def photo_params
    params.permit(:photo_file)
  end

  def gallery_json(gallery)
    {
      id: gallery.id,
      vehicle_id: gallery.vehicle_id,
      photo: gallery.photo_file.attached? ? url_for(gallery.photo_file) : nil
    }
  end
end
