# comment

class EventsController < ApplicationController

  before_filter :set_nav
  before_filter :get_event, :only => [:show, :edit, :update, :destroy]

  def index
    # display a list of events
    @page = 'Events'
    @header = 'Upcoming Events'
    @events = Event.order('start').all
  end

  def show
    # display a specific event
    @page = @header = @event.name
  end

  def edit
    # return an HTML form for editing a photo
    @page = 'Edit ' + @event.name
    @header = @event.name
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