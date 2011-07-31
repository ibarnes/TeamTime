class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def require_login
    unless current_user
   
      redirect_to new_session_path, :notice=>"Sorry, you must be logged in to access that." # halts request cycle
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

