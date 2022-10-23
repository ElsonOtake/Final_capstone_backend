class AuthenticationController < ApplicationController
  # protect_from_forgery unless: -> { request.format.json? }

  ALLOWED_DATA = %(name password).freeze

  # POST /auth/login
  def login
    data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
    @user = User.find_by_name!(data[:name])
    if @user.valid_password?(data[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'),
                     name: @user.name, role: @user.role }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Username not found' }, status: :not_found
  end
end
