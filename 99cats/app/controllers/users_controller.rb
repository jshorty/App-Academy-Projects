class UsersController < ApplicationController
  before_action :must_be_logged_out

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
