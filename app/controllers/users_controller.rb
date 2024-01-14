# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'Account created successfully!'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize_user(@user)
  end

  def update
    @user = User.find(params[:id])
    authorize_user(@user)
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Profile updated successfully!'
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @blogs = current_user.admin? ? Blog.all : current_user.blogs.where(approved: true)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password_digest, :role)
  end

  def require_login
    redirect_to login_path, notice: 'Please log in' unless current_user
  end

  def authorize_user(user)
    redirect_to root_path, notice: 'Access denied' unless current_user == user || current_user.admin?
  end
end
