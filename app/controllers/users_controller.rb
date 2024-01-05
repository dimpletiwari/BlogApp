class UsersController < ApplicationController

 def new
  @user = User.new
 end

 def create
  @user = User.new(user_params)
  if @user.save
    session[:user_id] = @user.id
    render json: {message: "user created successfully" }, status: :created
  else
    render json: {error: user.errors.full_messages}, status: :bad_request
  end
 end

 private

 def user_params
   params.require(:user).permit(:name, :email, :password_digest)
 end

end
