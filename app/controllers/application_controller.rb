class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def set_page nav, title, header
    valid_navs = ['Home', 'Events', 'Media', 'How to Join', 'About Us', 'Contact Us', 'User']
    @nav = if valid_navs.include?(nav) then nav else 'Home' end
    @page = title
    @header = header
  end

  helper_method :current_user, :set_page
end