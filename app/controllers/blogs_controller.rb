class BlogsController < ApplicationController
  def index
    @blogs = Blog.includes(:user).order("created_at DESC")
  end

  def show
    @blog = Blog.find_by(id: params[:id])
  end

  def new
    @blog = Blog.new
  end

  def create
    if Blog.create(create_params)
      flash[:notice] = '投稿を作成しました'
      redirect_to("/blogs")
    else
      render("blogs/new")
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    blog = Blog.find(params[:id])
    blog.update(update_params)
    redirect_to("/blogs")
  end

  def destroy
    blog = Blog.find(params[:id])
    binding.pry
    blog.destroy!
    redirect_to("/blogs")
  end

  private
  def create_params
    params.require(:blog).permit(:name,:text).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:blog).permit(:text)
  end
end
