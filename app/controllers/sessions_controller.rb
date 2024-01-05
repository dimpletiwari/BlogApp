class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password_digest])
      session[:user_id] = user.id
      redirect_to new_session_path, notice: 'Logged in successfully'
      # render json: {message: "login successful"}, status: :ok
    else
      render json: {error: "Invalid email or password"}, status: :unautherized
    end
 end

 def destroy
    session[:user_id] = nil
    render json: {message: "logout successfully"}, status: :ok
 end
end
