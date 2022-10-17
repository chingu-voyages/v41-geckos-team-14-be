require 'jwt'

class ApplicationController < ActionController::API
  SECRET = ENV['ENCODING_SECRET']

  def authentication
    decode_data = decode_user_data(request.headers['token'])
    user_data = decode_data[0]['user_id'] if decode_data
    user = User.find(user_data&.id)

    render status: 400, json: { message: 'invalid request' } unless user
  end

  def encode_user_data(payload)
    JWT.encode payload, SECRET, 'HS256'
  end

  def decode_user_data(token)
    JWT.decode token, SECRET, true, 'HS256'
  rescue JWT::ExpiredSignature
    render status: 422, json: { message: 'token expired' }
  rescue JWT::DecodeError
    render status: 422, json: { message: 'invalid token' }
  end
end
