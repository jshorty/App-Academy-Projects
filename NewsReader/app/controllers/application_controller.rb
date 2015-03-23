class ApplicationController < ActionController::Base
  protect_from_forgery

  def log_in(user)
    session[:token] = user.reset_session_token!
  end

  def current_user
    @current ||= User.find_by(session_token: session[:token])
  end

  def log_out
    current_user.reset_session_token!
  end

  helper_method :current_user
end
