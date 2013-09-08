class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def page_nav option
    valid_options = ['Home', 'Events', 'Media', 'How to Join', 'About Us', 'Contact Us', 'User']
    @nav = if valid_options.include?(option) then option else 'Home' end
  end

  helper_method :current_user, :page_nav
end