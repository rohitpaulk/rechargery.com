require 'mixpanel-ruby'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end

  def require_login
    if(!current_user)
      return_to = request.env['PATH_INFO']
      flash[:alert] = "You aren't signed in. Log in below, or create an acount."
      redirect_to(new_login_path(:return_to=>return_to))
      return true
    else
      return false
    end
  end

end
