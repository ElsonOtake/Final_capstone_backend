class Api::V1::GalleriesController < ApplicationController
  before_action :authorize_request
  before_action :authorize_admin, only: :create
  before_action :set_vehicle

  def index
    galleries = @vehicle.galleries.map { |gallery| gallery_json(gallery) }
    render json: galleries, status: :ok
  end

  def create
    if photo_params[:photo_file].blank?
      render json: { errors: ['photo_file is required'] }, status: :unprocessable_content
      return
    end

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

  # The photo_file parameter can arrive in two different shapes depending on
  # the client:
  #
  #   1. Nested under :gallery  ->  params[:gallery][:photo_file]
  #      This is how rswag sends it in the request specs, because the swagger
  #      parameter is declared as `name: :gallery` with an object schema, so
  #      the `let(:gallery)` hash gets wrapped under the "gallery" key.
  #
  #   2. Flat at the top level  ->  params[:photo_file]
  #      This is how Swagger UI (and most multipart clients) send it when a
  #      file is picked in the generated form, since the binary field is
  #      emitted as a top-level form field.
  #
  # Accept both so the endpoint works from Swagger UI and from the specs
  # without forcing either side to change. Falls back to the flat shape when
  # :gallery is absent, avoiding ActionController::ParameterMissing from
  # `params.require(:gallery)`.
  def photo_params
    if params[:gallery].present?
      params.require(:gallery).permit(:photo_file)
    else
      params.permit(:photo_file)
    end
  end

  def gallery_json(gallery)
    {
      id: gallery.id,
      vehicle_id: gallery.vehicle_id,
      photo: gallery.photo_file.attached? ? url_for(gallery.photo_file) : nil
    }
  end
end
