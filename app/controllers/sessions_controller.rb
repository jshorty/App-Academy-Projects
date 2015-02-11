class SessionsController < ApplicationController
  before_action :must_be_logged_out, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )
    @session_data = [params[:user][:env], params[:user][:ip]]

    if @user.nil?
      flash.now[:errors] = ["Invalid username or password!"]
      @user = User.new(user_name: params[:user][:user_name])
      render :new
    else
      login(@user, @session_data)
      redirect_to cats_url
    end
  end

  def destroy
    Session.find_by(token: session[:token]).destroy
    session[:token] = nil
    redirect_to cats_url
  end
end
