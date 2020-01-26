class UsersController < ApplicationController
  def signup
    user_params = params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    new_user = User.create!(user_params)

    auth_token = AuthenticateUser.new(email: new_user.email, password: new_user.password).call
    render json: { message: 'User successfully created', token: auth_token, status: 201 }
  end
end
