class Api::V1::SessionsController < ApplicationController
  # protect_from_forgery with: :null_session
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password_digest])
      render json: {message: "login successful"}, status: :ok
    else
      render json: {error: "Invalid email or password"}, status: :unautherized
    end
  end
end
