# The pages controller is for pages on the site with static content
# this basically just excludes the Events section of the site, which
# will_be/is dynamic 

class PagesController < ApplicationController

  def index
    set_page 'Home', 'Home', nil, "The new website for the University of Alaska Anchorage's chapter of Alpha Phi Omega: Alpha Zeta Eta. APO is a America's largest national service fraternity and has Leadership, Friendship, and Service as its cardinal principals. This is a place where we can stay current on chapter activities, see some of our history and learn about our organization."
  end

  def join
    set_page 'How to Join', 'How to Join', 'How to Join our Chapter', 'See how you can join our APO chapter, including details about upcoming and past Rush schedules, Pledging, and Active Membership.'
  end

  def pledge_signup
    set_page 'How to Join', 'Sign up as a potential pledge', nil, nil
  end

  def about
    set_page 'About Us', 'About Us', 'About our Organization', 'Learn about Alpha Phi Omega as a national fraternity and about the history of our chapter.'
  end

  def contact
    set_page 'Contact Us', 'Contact Us', 'Contact Us', nil
  end

  def conference
    set_page 'Events', '2013 Section 8 Conference', '2013 Section 8 Conference', nil
  end

  def conference_register
    set_page 'Events', 'Register for the Conference', nil, nil
  end

  def bylaws
    set_page 'Media', 'Chapter Bylaws', 'Alpha Zeta Eta Chapter Bylaws', nil
  end

  def test
    # http_basic_authenticate_with :name => "frodo", :password => "thering"
    set_page 'Home', 'Test Page', 'Test Page', nil
  end
end