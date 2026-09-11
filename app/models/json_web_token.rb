class JsonWebToken
  SECRET_KEY = Rails.application.credentials.secret_key_base || Rails.application.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    token = JWT.encode(payload, SECRET_KEY)
    [token, exp]
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')[0]
    HashWithIndifferentAccess.new decoded
  end
end
