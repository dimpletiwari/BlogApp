class Api::V1::PostsController < ApplicationController
  # protect_from_forgery with: :null_session
  before_action :authenticate_user

  def index
    @posts = current_user.posts
    render json: @posts
  end

  private

  def authenticate_user
    token = request.headers['Authorization']
    user = User.find_by(auth_token: token)
    unless user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
