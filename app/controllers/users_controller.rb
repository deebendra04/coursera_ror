class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    user = User.create(user_params)
    if user.persisted?
      render json: { message: 'User created successfully', user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password_digest, :role)
  end
end
  