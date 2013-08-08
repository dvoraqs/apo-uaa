# comment

class EventsController < ApplicationController

  before_filter :set_nav
  before_filter :get_event, :only => [:show, :edit, :update, :destroy]

  def index
    # display a list of events
    @page = 'Events'

    time = if params['time'] == nil then 0 else params['time'].to_i end
    
    now = DateTime.now
    range_start = now.advance(:months => time * 6)
    range_end = now.advance(:months => (time + 1) * 6)

    if time == 0
      @header = "Upcoming Events"
    else
      @header = range_start.strftime('%b %Y') + ' to ' + range_end.strftime('%b %Y')
    end

    @events = Event.order('start').where('end > ? and ? > start', range_start, range_end).all
    first_event = Event.order('start').first
    last_event = Event.order('end').last

    if first_event != nil && range_start > DateTime.parse(first_event.start)
      @prev = time - 1
    else
      @prev = nil
    end

    if last_event != nil && range_end < DateTime.parse(last_event.end)
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
      redirect_to event_path(event)
    end
  end

  def update
    # update a specific event
    if @event.update_attributes(params[:event])
      redirect_to event_path(@event)
    end
  end

  def destroy
    # delete a specific event
    @event.destroy
    redirect_to events_path
  end

  def set_nav
    @nav = 'Events'
  end

  def get_event
    @event = Event.find(params[:id])
  end

  def google_calendar
    require 'rubygems'
    require 'google/api_client'
    require 'yaml'

    oauth_yaml = YAML.load_file('.google-api.yaml')
    client = Google::APIClient.new
    client.authorization.client_id = oauth_yaml["client_id"]
    client.authorization.client_secret = oauth_yaml["client_secret"]
    client.authorization.scope = oauth_yaml["scope"]
    client.authorization.refresh_token = oauth_yaml["refresh_token"]
    client.authorization.access_token = oauth_yaml["access_token"]

    if client.authorization.refresh_token && client.authorization.expired?
      client.authorization.fetch_access_token!
    end

    service = client.discovered_api('calendar', 'v3')
  end
end