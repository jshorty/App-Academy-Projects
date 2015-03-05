class SessionController < ApplicationController
  def create
    @user = User.find_by_credentials(user_params)
    if @user
      log_in(@user)
      render json: @user
    else
      render json: {"Invalid username or password"}, status: 422
    end
  end

  def destroy
    log_out
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
