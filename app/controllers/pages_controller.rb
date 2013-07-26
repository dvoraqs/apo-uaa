# The pages controller is for pages on the site with static content
# this basically just excludes the Events section of the site, which
# will_be/is dynamic 

class PagesController < ApplicationController

  def index
    @page = @nav = 'Home'
    @header = nil
  end

  def join
    @page = @nav = 'How to Join'
    @header = 'How to Join our Chapter'
  end

  def about
    @page = @nav = 'About Us'
    @header = 'About our Organization'
  end

  def contact
    @page = @header = @nav = 'Contact Us'
  end
end