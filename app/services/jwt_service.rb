class JwtService
  SECRET_KEY = ENV['JWT_SECRET_KEY'].freeze

  def self.encode(payload, exp = 1.hours.from_now)
    payload[:exp] = exp.to_i
    token = JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })
    HashWithIndifferentAccess.new(decoded_token.first)
  rescue JWT::DecodeError
    nil
  end
end
