class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def log_in_user!(user)
    session[:token] = user.reset_session_token!
  end

  def log_out_user!(user)
    user.reset_session_token!
    session[:token] = nil
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:token])
  end

  def logged_in?
    !!current_user
  end

  def require_logged_in
    unless logged_in?
      flash[:errors] = ["Must be logged in do that!"]
      redirect_to new_session_url
    end
  end
end
