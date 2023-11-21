class JwtService
  SECRET_KEY = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 1.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
    HashWithIndifferentAccess.new(decoded_token[0])
  rescue JWT::DecodeError
    nil
  end
end
