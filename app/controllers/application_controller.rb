class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user
    return nil unless session[:token]
    @current ||= User.find_by(session_token: session[:token])
  end

  def login(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end

  helper_method :current_user, :login

  def must_be_logged_out
    unless current_user.nil?
      flash[:errors] = ["You're already logged in!"]
      redirect_to cats_url
    end
  end
end
