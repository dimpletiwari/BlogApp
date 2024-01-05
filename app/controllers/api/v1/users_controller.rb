class Api::V1::UsersController < ApplicationController
  # protect_from_forgery with: :null_session
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {message: "user created successfully" }, status: :ok
    else
      render json: {error: @user.errors.full_messages }, status: :unprocessable_entry
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password_digest)
  end
end
