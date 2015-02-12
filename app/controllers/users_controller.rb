class UsersController < ApplicationController
  before_action :ensure_logged_in, only: :show

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.activation_email(@user).deliver
      redirect_to new_session_url
      flash[:errors] = ["check your email for an activation link!"]
    else
      flash.now[:errors] = ["invalid user information"]
      render :new
    end
  end

  def show
    @user = current_user
    render :show
  end

  def activate
    @user = User.find_by(activation_token: params[:activation_token])
    if @user.nil?
      redirect_to new_session_url
    else
      @user.activate!
      log_in!(@user)
    end
  end
end
