class PostsController < ApplicationController
  # before_action :require_user!, only: [:create, :new, :update]

  def new
    @post = Post.new
    render :new
  end

  def create
    @posts = current_user.posts.new(post_params)
    @sub_id = params[:sub_id]
    @post.sub_id = params[:sub_id]
    if @post.save
      redirect_to sub_url(@post.sub_id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = post.find(params[:id])
    render :edit
  end

  def update
    @post = post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end

  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
