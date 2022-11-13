class SessionsController < ApplicationController
  def signup
    user = User.new(username: params[:username], password: params[:password])

    if user.password && user.username && user.save
      token = encode_user_data({ user_data: user.id })
      render status: 201, json: { token: }
    else
      render  status: 400, json: { message: 'invalid request' }
    end
  end

  def login
    user = User.find_by(username: params[:username])

    if user && user.password == params[:password]

      token = encode_user_data({ user_data: user.id, exp: 24.hours.from_now.to_i })

      render status: 200, json: { token: }
    else
      render status: 422, json: { message: 'invalid credentials' }
    end
  end
end
