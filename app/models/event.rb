class Event < ActiveRecord::Base
  attr_accessible :title, :start, :end, :location, :status, :description

  before_save do |e|
  	if e.description == ''
  	  e.description = nil
  	end
  end

  def more_than_a_day
  	self.start_date.advance(:days => 1) < self.end_date
  end

  def start_date
  	DateTime.parse(self[:start])
  end

  def start_date_short
  	self.start_date.strftime('%m/%d ')
  end

  def start_year
  	self.start_date.strftime('%Y')
  end

  def start_month_caps
  	self.start_date.strftime('%^b')
  end

  def start_day
  	self.start_date.strftime('%d')
  end

  def start_weekday
  	self.start_date.strftime('%a ')
  end

  def start_weekday_caps
  	self.start_date.strftime('%^a')
  end

  def start_time
  	if self.start_date.strftime('%M') == '00'
      self.start_date.strftime('%l%P')
    else
      self.start_date.strftime('%l:%M%P')
    end
  end

  # all of the same for the end date

  def end_date
  	# rewrite 12:00am end dates to fall inside the end of the previous day
  	date = DateTime.parse(self[:end])
  	if date.strftime('%l:%M%P') != '12:00am'
      date
    else
      date.advance(:seconds => -1)
    end
  end

  def end_date_short
  	self.end_date.strftime('%m/%d ')
  end

  def end_year
  	self.end_date.strftime('%Y')
  end

  def end_month_caps
  	self.end_date.strftime('%^b')
  end

  def end_day
  	self.end_date.strftime('%d')
  end

  def end_weekday
  	self.end_date.strftime('%a ')
  end

  def end_weekday_caps
  	self.end_date.strftime('%^a')
  end

  def end_time
  	# rewrite 12:00am end dates to fall inside the end of the previous day
  	if self.end_date.strftime('%M') == '00'
      self.end_date.strftime('%l%P')
    else
      self.end_date.strftime('%l:%M%P')
    end
  end

  def time
    start_day = end_day = ''
    if self.end_date > self.start_date.advance(:days => 1)
      if self.end_date < self.start_date.advance(:days => 7)
        start_day = self.start_weekday + ' '
        end_day = self.end_weekday + ' '
      else
        start_day = self.start_date_short + ' '
        end_day = self.start_date_short + ' '
      end
    end

    if !(self.start_time == '12am' && self.end_time == '11:59pm')
      start_day + self.start_time + ' - ' + end_day + self.end_time
    elsif start_day != end_day
      start_day + ' - ' + end_day
    else
      'All day'
    end
  end
end