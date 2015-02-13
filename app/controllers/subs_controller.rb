class SubsController < ApplicationController
  before_action :is_moderator, only: [:edit, :update, :destroy]

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub.id)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub.id)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def index
    @subs = Sub.all
    render :index
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  def is_moderator
    unless current_user.id == Sub.find(params[:id]).moderator_id
      flash[:errors] = ["You are not a moderator for this sub"]
      redirect_to subs_url
    end
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
