# comment

class EventsController < ApplicationController

  before_filter :set_nav
  before_filter :get_event, :only => [:show, :edit, :update, :destroy]
  before_filter :check_auth, :only => [:new, :create, :edit, :update, :destroy]

  def index
    # display a list of events
    
    now = DateTime.now
    time = if params['time'] == nil then 0 else params['time'].to_i end
    
    first_event = Event.order('start').first
    range_start = now.advance(:months => time * 6)
    if first_event != nil && range_start > first_event.start || range_start > now
      @prev = time - 1
    else
      @prev = nil
    end

    last_event = Event.order('end').last
    range_end = now.advance(:months => (time + 1) * 6)
    if last_event != nil && range_end < last_event.end || range_end < now
      @next = time + 1
    else
      @next = nil
    end

    @events = []
    events = Event.where('? > start and (end > ? or recurs_until > ?)', range_end, range_start, range_start).all
    events.each do |e|
      
      if e.recurrence_rule != nil and e.recurs_until != nil
        recurrence = 1
        until e.start_date > range_end or e.end_date > e.recurs_until or recurrence > 10
          @events.push(e)
          e = e.clone
          e.set_recurrence recurrence
          recurrence = recurrence + 1
        end
      else
        @events.push(e)
      end
    end

    @events = @events.sort_by {|e| e.start_date}
    @page = 'Events'
    @header = if time >= 0 then 'Upcoming Events' else 'Past Events' end
    @range = range_start.strftime('%b %Y') + ' to ' + range_end.strftime('%b %Y')
    
  end

  def show
    # display a specific event
    @page = @header = @event.title
    @event.recurrence = if params['recurrence'] == nil then 0 else params['recurrence'].to_i end
  end

  def edit
    # return an HTML form for editing an event
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
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = 'Successfully created event ' + @event.title
      redirect_to event_path(@event)
    else
      flash.now[:alert] = 'There were problems creating the event'
      @page = @header = 'New Event'
      render 'new'
    end
  end

  def update
    # update a specific event
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Successfully updated event ' + @event.title
      redirect_to event_path(@event)
    else
      flash.now[:alert] = 'There were problems updating event ' + @event.title
      @page = 'Edit ' + @event.title
      @header = @event.title
      render 'edit'
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
    page_nav 'Events'
  end

  def get_event
    @event = Event.find(params[:id])
  end

  def check_auth
    if current_user == nil or current_user.access_level < 2 or current_user.access_level == 2 and @event != nil and current_user != @event.user
      redirect_to events_path, :alert => "Must be logged in with a verified Member/Officer account"
    end
  end
end