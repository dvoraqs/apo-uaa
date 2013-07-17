# comment

class EventsController < ApplicationController

  def index
    @page = @header = @nav = 'Events'
    # @header = 'Events'
  end

  def conference
    @page = @header = '2013 Section 8 Conference'
    @nav = 'Events'
    # @header = '2013 Section 8 Conference'
  end

  def register
    @page = 'Register for the Conference'
    @header = nil
    @nav = 'Events'
  end
end