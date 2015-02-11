class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if @user.nil?
      flash.now[:errors] = ["Invalid username or password!"]
      @user = User.new(user_name: params[:user][:user_name])
      render :new
    else
      @user.reset_session_token
      session[:token] = @user.session_token
      redirect_to cats_url
    end
  end

  def destroy
  end
end
