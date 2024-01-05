class PostsController < ApplicationController
  before_action :authenticate_user, only: [:index]

  def index
    posts = current_user.posts
    render json: posts, status: :ok
  end

  private

  def authenticate_user
    unless current_user
      flash[:alert] = 'You must be logged in to access this section.'
      redirect_to login_path
    end
  end
end
