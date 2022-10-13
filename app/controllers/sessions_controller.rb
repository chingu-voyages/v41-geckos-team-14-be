class SessionsController < ApplicationController
  def signup
    user = User.new(email: params[:email], password: params[:password])

    if user.save
      token = encode_user_data({ user_data: user.id })
      render json: { token: }
    else
      render json: { message: 'Email is already in use' }
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user && user.password == params[:password]

      token = encode_user_data({ user_data: user.id, exp: 24.hours.from_now.to_i })

      render json: { token: }
    else
      render json: { message: 'invalid credentials' }
    end
  end
end
