require 'jwt'

class ApplicationController < ActionController::API
  SECRET = ENV['ENCODING_SECRET']

  def authenticate_user
    unless request.headers['Authorization']
      render status: 400, json: { message: 'invalid request' }
      return
    end
    decoded_data = decode_user_data(request.headers['Authorization'].split(' ')[1])
    return decoded_data if decoded_data.include? 'Error:'

    decoded_data[0]['user_data']
  end

  def encode_user_data(payload)
    JWT.encode payload, SECRET, 'HS256'
  end

  def decode_user_data(token)
    JWT.decode token, SECRET, true, { algorithm: 'HS256' }
  rescue JWT::ExpiredSignature
    render status: 422, json: { message: 'Error: token expired' }
  rescue JWT::DecodeError
    render status: 422, json: { message: 'Error: invalid token' }
  end
end
