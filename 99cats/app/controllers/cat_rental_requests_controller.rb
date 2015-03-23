class CatRentalRequestsController < ApplicationController
  before_action :validate_login, only: :new
  before_action :ensure_cat_ownership, only: [:approve, :deny]


  def new
    @request = CatRentalRequest.new
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    @request.user_id = current_user.id
    if @request.save
      redirect_to cat_url(@request.cat_id)
    else
      render :new
    end
  end

  def approve
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to cat_url(@request.cat_id)
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
    redirect_to cat_url(@request.cat_id)
  end

  private

  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

  def ensure_cat_ownership
    cat = CatRentalRequest.find(params[:id]).cat
    unless current_user == cat.owner
      flash[:errors] = ["You can't handle requests for someone else's cat!"]
      redirect_to cat_url(cat.id)
    end
  end

  def validate_login
    unless current_user
      flash[:errors] = ["Log in or sign up to rent a cat today!"]
      redirect_to new_session_url
    end
  end
end
