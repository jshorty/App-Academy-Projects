class UsersController < ApplicationController
  before_action :ensure_logged_in, only: :show

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to user_url(@user.id)
    else
      flash.now[:errors] = ["invalid user information"]
      render :new
    end
  end

  def show
    @user = current_user
    render :show
  end
end
