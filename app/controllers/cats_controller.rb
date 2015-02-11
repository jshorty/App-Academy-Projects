class CatsController < ApplicationController
  before_action :ensure_cat_ownership, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id if current_user
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = ["Invalid cat attributes."]
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :birth_date, :color, :description)
  end

  def ensure_cat_ownership
    unless current_user == Cat.find(params[:id]).owner
      flash[:errors] = ["You can only edit your own cats!"]
      redirect_to cat_url(params[:id])
    end

  end
end
