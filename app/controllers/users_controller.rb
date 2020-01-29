# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorize_request!

  def signup
    new_user = User.create!(signup_params)

    auth_token = AuthenticateUser.new(email: new_user.email,
                                      password: new_user.password).call
    render json: {
      message: 'User successfully created',
      token: auth_token,
      status: 201
    }
  end

  def signin
    auth_token = AuthenticateUser.new(email: sigin_params[:email],
                                      password: sigin_params[:password]).call
    render json: {
      message: 'User successfully signed in',
      token: auth_token,
      status: 200
    }
  end

  private

  def sigin_params
    params.permit(:email, :password)
  end

  def signup_params
    params.permit(
      :first_name, :last_name, :email, :role, :password, :password_confirmation
    )
  end
end
