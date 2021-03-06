class SubsController < ApplicationController

  before_action :require_user!, only: [:create, :new, :update]

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end


  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end

  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
