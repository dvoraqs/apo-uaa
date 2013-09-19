# The pages controller is for pages on the site with static content
# this basically just excludes the Events section of the site, which
# will_be/is dynamic 

class PagesController < ApplicationController

  def index
    set_page 'Home', 'Home', nil
  end

  def join
    set_page 'How to Join', 'How to Join', 'How to Join our Chapter'
  end

  def pledge_signup
    set_page 'How to Join', 'Sign up as a potential pledge', nil
  end

  def about
    set_page 'About Us', 'About Us', 'About our Organization'
  end

  def contact
    set_page 'Contact Us', 'Contact Us', 'Contact Us'
  end

  def conference
    set_page 'Events', '2013 Section 8 Conference', '2013 Section 8 Conference'
  end

  def conference_register
    set_page 'Events', 'Register for the Conference', nil
  end

  def bylaws
    set_page 'Media', 'Chapter Bylaws', 'Alpha Zeta Eta Chapter Bylaws'
  end

  def test
    # http_basic_authenticate_with :name => "frodo", :password => "thering"
    set_page 'Home', 'Test Page', 'Test Page'
  end
end