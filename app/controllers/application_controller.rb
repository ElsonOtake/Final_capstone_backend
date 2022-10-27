class ApplicationController < ActionController::API
  def json_payload
    return [] if request.raw_post.empty?

    HashWithIndifferentAccess.new(JSON.parse(request.raw_post))
  end

  # def current_user
  #   header = request.headers['Authorization']
  #   if header.empty?
  #     @current_user = nil
  #   else
  #     header = header.split.last
  #     begin
  #       @decoded = JsonWebToken.decode(header)
  #       @current_user = User.find_by_id!(@decoded[:user_id])
  #     rescue ActiveRecord::RecordNotFound || JWT::DecodeError
  #       @current_user = nil
  #     end
  #   end
  # end

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    if header
      header = header.split.last
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find_by_id!(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound || JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    else
      render json: { errors: 'Unauthorized user' }, status: :unauthorized
    end
  end
end
