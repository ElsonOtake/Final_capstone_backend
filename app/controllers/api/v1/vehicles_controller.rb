class Api::V1::VehiclesController < ApplicationController
  before_action :authorize_request
  before_action :find_vehicle, except: %i[create index]

  ALLOWED_DATA = %(model description year brand color country power max_speed acceleration price).freeze

  def index
    vehicles = Vehicle.all
    render json: vehicles, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicles not found' }, status: :not_found
  end

  def show
    render json: @vehicle, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end

  def create
    if current_user.is? :admin
      data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
      if data.empty?
        return render json: { error: 'Empty body. Could not create vehicle.' },
                      status: :unprocessable_entity
      end

      vehicle = Vehicle.new(data)
      if vehicle.save
        render json: vehicle, status: :ok
      else
        render json: { error: 'Could not create vehicle.' }, status: :unprocessable_entity
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
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Vehicle not found' }, status: :not_found
  end
end
