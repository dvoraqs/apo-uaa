# comment

class EventsController < ApplicationController

  before_filter :set_nav
  before_filter :get_event, :only => [:show, :edit, :update, :destroy]
  before_filter :check_auth, :only => [:new, :create, :edit, :update, :destroy]

  def index
    # display a list of events
    @page = 'Events'

    time = if params['time'] == nil then 0 else params['time'].to_i end
    
    now = DateTime.now
    range_start = now.advance(:months => time * 6)
    range_end = now.advance(:months => (time + 1) * 6)
    @range = range_start.strftime('%b %Y') + ' to ' + range_end.strftime('%b %Y')

    if time >= 0
      @header = "Upcoming Events"
    else
      @header = "Past Events"
    end

    @events = Event.order('start').where('end > ? and ? > start', range_start, range_end).all
    first_event = Event.order('start').first
    last_event = Event.order('end').last

    if first_event != nil && range_start > DateTime.parse(first_event.start) || range_start > now
      @prev = time - 1
    else
      @prev = nil
    end

    if last_event != nil && range_end < DateTime.parse(last_event.end) || range_end < now
      @next = time + 1
    else
      @next = nil
    end
  end

  def show
    # display a specific event
    @page = @header = @event.title
  end

  def edit
    # return an HTML form for editing a photo
    @page = 'Edit ' + @event.title
    @header = @event.title
  end

  def new
    # return an HTML form for creating a new event
    @page = @header = 'New Event'
    @event = Event.new
  end

  def create
    # create a new event
    event = Event.new(params[:event])
    if event.save
      flash[:notice] = 'Event created successfully'
      redirect_to event_path(event)
    end
  end

  def update
    # update a specific event
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event updated successfully'
      redirect_to event_path(@event)
    end
  end

  def destroy
    # delete a specific event
    if @event.destroy
      flash[:notice] = 'Event deleted successfully'
      redirect_to events_path
    end
  end

  def set_nav
    @nav = 'Events'
  end

  def get_event
    @event = Event.find(params[:id])
  end

  def check_auth
    if current_user == nil || current_user.access_level < 1
      redirect_to events_path, :alert => "Must be logged in with a verified Member/Officer account"
    end
  end
end