class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password_digest])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully'
      # render json: {message: "login successful"}, status: :ok
    else
      render json: {error: "Invalid email or password"}, status: :unautherized
    end
 end

 def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully!'
 end
end
