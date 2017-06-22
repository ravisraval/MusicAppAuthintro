class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :login, :current_user, :logged_in?

  def login(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def logout
    @current_user.try(:reset_session_token!) #if no user, doesn't raise error
    session[:session_token] = nil
  end
end
