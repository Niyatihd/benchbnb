class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  def login(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def logout
    current_user.reset_session_token!
    session[session_token] = nil
    @current_user = nil
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless current_user
      render json: {base: ['Please Sign In']}, status: 401
    end
  end
end
