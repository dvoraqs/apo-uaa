

class Event < ActiveRecord::Base
  attr_accessible :title, :start, :end, :location, :status, :description, :recurrence_rule, :recurs_until, :user_id
  attr_accessor :recurrence

  validates_presence_of :title
  validates_presence_of :start
  validates_presence_of :end
  belongs_to :user

  before_save do |e|
    if e.description == ''
      e.description = nil
    end
    if e.recurrence_rule == ''
      e.recurrence_rule = nil
    end
    if e.end_as('hour:minute am/pm') == '12:00am'
      # rewrite 12:00am end dates to fall inside the end of the previous day
      e.end = e.end.advance(:seconds => -1)
    end
  end

  @@_date_formats = {'date short' => '%m/%d ', 'year' => '%Y', 'month' => '%b',
      'month caps' => '%^b', 'day' => '%d', 'weekday' => '%a', 
      'weekday caps' => '%^a', 'minute' => '%M', 'hour am/pm' => '%l%P', 
      'hour:minute am/pm' => '%l:%M%P'}

  @@_recurrence_intervals = {'DAILY' => :days, 'WEEKLY' => :weeks, 
      'MONTHLY' => :months, 'YEARLY' => :years}

  def more_than_a_day
    self.start_date.advance(:days => 1) < self.end_date
  end

  def set_recurrence recurrence
    @recurrence = recurrence
  end

  def start_date
    # Time.zone = "Alaska" # For when/if we store user time zones
    if @recurrence != nil and self.recurrence_rule != nil and @@_recurrence_intervals.has_key?(self.recurrence_rule)
      interval = @@_recurrence_intervals[self.recurrence_rule]
      self[:start].advance(interval => @recurrence)
    else
      self[:start]
    end
  end

  def end_date
    # Time.zone = "Alaska"
    if @recurrence != nil and self.recurrence_rule != nil and @@_recurrence_intervals.has_key?(self.recurrence_rule)
      interval = @@_recurrence_intervals[self.recurrence_rule]
      self[:end].advance(interval => @recurrence)
    else
      self[:end]
    end
  end

  def start_as format
    self.start_date.strftime(@@_date_formats[format])
  end

  def end_as format
    self.end_date.strftime(@@_date_formats[format])
  end

  def start_time
    if self.start_as('minute') == '00'
      self.start_as('hour am/pm')
    else
      self.start_as('hour:minute am/pm')
    end
  end
  
  def end_time
    # rewrite 12:00am end dates to fall inside the end of the previous day
    if self.end_as('minute') == '00'
      self.end_as('hour am/pm')
    else
      self.end_as('hour:minute am/pm')
    end
  end

  def full_date
    date = self.start_as('year') + ' ' + self.start_as('month') + ' ' + start_as('day')

    if self.more_than_a_day
      date = date + ' - '
    end

    if self.start_as('year') != self.end_as('year')
      date = date + ' ' + self.end_as('year')
    end

    if self.start_as('year') + self.start_as('month') != self.end_as('year') + self.end_as('month')
      date = date + ' ' + self.end_as('month')
    end

    if self.more_than_a_day
      date = date + ' ' + self.end_as('day')
    end

    if !self.more_than_a_day
      date = date + ' (' + self.start_as('weekday') + ')'
    elsif self.end_date < self.start_date.advance(:days => 7)
      date = date + ' (' + self.start_as('weekday') + ' - ' + self.end_as('weekday') + ')'
    end
  end

  def time
    start_day = end_day = ''
    if self.end_date > self.start_date.advance(:days => 1)
      if self.end_date < self.start_date.advance(:days => 7)
        start_day = self.start_as('weekday') + ' '
        end_day = self.end_as('weekday') + ' '
      else
        start_day = self.start_as('date_short') + ' '
        end_day = self.start_as('date_short') + ' '
      end
    end

    if !(self.start_time == '12am' && self.end_time == '11:59pm')
      start_day + self.start_time + ' - ' + end_day + self.end_time
    elsif start_day != end_day
      'All day ' + start_day + ' - ' + end_day
    else
      'All day'
    end
  end
end