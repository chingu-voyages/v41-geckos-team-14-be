require 'jwt'

class ApplicationController < ActionController::API
  SECRET = ENV['ENCODING_SECRET']

  def authentication
    decode_data = decode_user_data(request.headers['token'])
    user_data = decode_data[0]['user_id'] if decode_data
    user = User.find(user_data&.id)

    render json: { message: 'invalid credentials' } unless user
  end

  def encode_user_data(payload)
    JWT.encode payload, SECRET, 'HS256'
  end

  def decode_user_data(token)
    JWT.decode token, SECRET, true, 'HS256'
  rescue JWT::ExpiredSignature
    render json: { message: 'token expired' }
  rescue JWT::DecodeError
    render json: { message: 'invalid token' }
  end
end
