class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(email: params[:email],
                     password: params[:password])
    if @user.save
      #redirect_to
    else
      flash.now[:errors] = ["invalid user information"]
      render :new
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
end
