class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def log_in!(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end

  def log_out!(user)
    user.reset_session_token!
    session[:token] = nil
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def current_user
    @current ||= User.find_by(session_token: session[:token])
  end

  def logged_in?
    !!current_user
  end

  def ensure_logged_in
    unless logged_in?
      flash[:errors] = ["You must be logged in to do that!"]
      redirect_to new_session_url
    end
  end

  helper_method :current_user, :logged_in?, :log_in!, :log_out!, :ensure_logged_in
end
