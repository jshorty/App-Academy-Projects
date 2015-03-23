class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user
    return nil unless session[:token]
    @current ||= Session.find_by(token: session[:token]).user
  end

  def login(user, session_data)
    @session = Session.new(
      user_id: user.id,
      token: SecureRandom::urlsafe_base64(16),
      env: request.env["HTTP_USER_AGENT"],
      ip: request.remote_ip
    )

    if @session.save
      session[:token] = @session.token
      redirect_to cats_url
    else
      flash[:errors] = ["Login failed, invalid session."]
      redirect_to new_session_url
  end

  helper_method :current_user, :login

  def must_be_logged_out
    unless current_user.nil?
      flash[:errors] = ["You're already logged in!"]
      redirect_to cats_url
    end
  end
end
