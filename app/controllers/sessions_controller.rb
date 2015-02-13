class SessionsController < ApplicationController

  def new
    @user = User.new
    @session = true
    render :new
  end

  def create
    @user = User.find_by_credentials(
        params[:user][:username],
        params[:user][:password]
    )

    if @user.nil?
      flash.now[:errors] = @user.errors.full_messages
      render :new
    else

      log_in_user!(@user)
      redirect_to user_url(@user.id)
    end
  end

  def destroy
    log_out_user!(current_user)
    redirect_to new_session_url
  end

end
