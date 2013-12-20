class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def activate_user_wall
    redirect_to root_path unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
