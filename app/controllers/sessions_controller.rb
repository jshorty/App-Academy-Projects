class SessionsController < ApplicationController

  def new
    @login = true
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:email],
                                     user_params[:password])
    if @user.nil?
      flash.now[:errors] = ["invalid email or password"]
      @user = User.new(email: user_params[:email])
      @login = true
      render :new
    else
      log_in!(@user)
      redirect_to new_url(@user.id)
    end
  end

  def destroy
    @user = current_user
    log_out!(@user)
    redirect_to new_session_url
  end


end
