class Api::V1::VehiclesController < ApplicationController
  before_action :authorize_request
  before_action :find_vehicle, except: %i[create index]

  ALLOWED_DATA = %w[model description year brand color country power max_speed acceleration price].freeze

  def index
    vehicles = Vehicle.all
    render json: vehicles, status: :ok
  end

  def show
    render json: @vehicle, status: :ok
  end

  def create
    if current_user.is? :admin
      data = json_payload.slice(*ALLOWED_DATA)
      if data.empty?
        return render json: { error: 'Empty body. Could not create vehicle.' },
                      status: :unprocessable_content
      end

      vehicle = Vehicle.new(data)
      if vehicle.save
        render json: vehicle, status: :ok
      else
        render json: { error: vehicle.errors.full_messages }, status: :unprocessable_content
      end
    else
      render json: { error: 'Unauthorized.' }, status: :unauthorized
    end
  end

  def destroy
    if current_user.is? :admin
      @vehicle.destroy
      render json: @vehicle, status: :ok
    else
      render json: { error: 'Unauthorized.' }, status: :unauthorized
    end
  end

  private

  def find_vehicle
    @vehicle = Vehicle.find_by_id!(params[:id])
  end
end
