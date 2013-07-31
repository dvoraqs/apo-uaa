# comment

class EventsController < ApplicationController

  before_filter :set_nav
  before_filter :get_events, :only => [:index]
  before_filter :get_event, :only => [:show, :edit, :update, :destroy]

  def index
    # display a list of events

    @page = 'Events'
    @header = 'Upcoming Events'
  end

  def show
    # display a specific event

    @page = @header = @event.name
  end

  def edit
    # return an HTML form for editing a photo

    @page = @header = 'Edit ' + @event.name
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
      redirect_to event_path(event)
    end
  end

  def update
    # update a specific event

    # do stuff
    redirect_to event_path(@event)
  end

  def destroy
    # delete a specific event

    # do stuff
    redirect_to events_path
  end

  def set_nav
    @nav = 'Events'
  end

  def get_events
    @events = Event.order('start').all

    # @events.each do |event|
    #   start_date = DateTime.parse(event.start)
    #   end_date = DateTime.parse(event.end)

    #   while start_date.advance(:days => 1) < end_date
    #     start_date = start_date.advance(:days => 1)
    #     end_date = start_date.advance(:seconds => -1)
        
    #     # copy event
    #     event_copy = Event.new
    #     event_copy.id = event.id
    #     event_copy.name = event.name
    #     event_copy.start = start_date.strftime('%F %R')
    #     event_copy.end = event.end
    #     event_copy.summary = "Multi-day Event Continued from " + event.start
    #     event_copy.location = event.location
    #     event_copy.status = event.status
    #     @events.push(event_copy)

    #     # change end time for current event
    #     event.end = end_date.strftime('%F %R')
    #   end 
    # end
  end

  def get_event
    @event = Event.find(params[:id])
  end
end