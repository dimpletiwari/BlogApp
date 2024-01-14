class BlogsController < ApplicationController
  before_action :require_login
  before_action :find_blog, only: %i[edit update show]

  def new
    @blog = current_user.blogs.build
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to user_path(current_user), notice: 'Blog created successfully!'
    else
      render :new
    end
  end

  def edit
    authorize_blog(@blog)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    authorize_blog(@blog)
    if @blog.update(blog_params)
      respond_to do |format|
        format.html { redirect_to user_path(current_user), notice: 'Blog updated successfully!' }
        format.js
      end
    else
      # Handle update errors
    end
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Blog deleted successfully!' }
      format.js
    end
  end

  def show
  end

  def index
   # @blogs = current_user.admin? ? Blog.all : current_user.blogs.where(approved: true)
   @title_filter = params[:title_filter]
    @date_filter = params[:date_filter]

    @blogs = filtered_blogs

    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :approved)
  end

  def require_login
    redirect_to login_path, notice: 'Please log in'
  end

  def find_blog
    @blog = Blog.find(params[:id])
  end

  def authorize_blog(blog)
    redirect_to root_path, notice: 'Access denied' unless current_user.admin? || current_user == blog.user
  end

  def filtered_blogs
    blogs = current_user.admin? ? Blog.all : current_user.blogs.where(approved: true)
    blogs = blogs.where('title LIKE ?', "%#{@title_filter}%") if @title_filter.present?
    blogs = blogs.where('publication_date = ?', @date_filter) if @date_filter.present?
    blogs
  end
end
