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

  def pledge_signup
    @nav = 'How to Join'
    @page = 'Sign up as a potential pledge'
    @header = nil
  end

  def about
    @page = @nav = 'About Us'
    @header = 'About our Organization'
  end

  def contact
    @page = @header = @nav = 'Contact Us'
  end

  def conference
    @page = @header = '2013 Section 8 Conference'
    @nav = 'Events'
  end

  def conference_register
    @page = 'Register for the Conference'
    @header = nil
    @nav = 'Events'
  end

  def bylaws
    @page = "Chapter Bylaws"
    @header = "Alpha Zeta Eta Chapter Bylaws"
    @nav = 'Media'
  end

  def test
    @nav = 'Home'
    @page = @header = 'Test Page'
  end
end