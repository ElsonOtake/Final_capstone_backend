class AuthenticationController < ApplicationController
  ALLOWED_DATA = %w[name password].freeze

  # POST /auth/login
  def login
    data = json_payload.slice(*ALLOWED_DATA)
    @user = User.find_by(name: data[:name])
    if @user&.valid_password?(data[:password])
      token, expires_at = JsonWebToken.encode(user_id: @user.id)
      render json: { token:, exp: expires_at.strftime('%m-%d-%Y %H:%M'),
                     name: @user.name, role: @user.role, id: @user.id }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end
end
