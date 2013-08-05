class Event < ActiveRecord::Base
  attr_accessible :name, :start, :end, :location, :status, :summary

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
  	self.start_date.strftime('%l%P')
  end

  def start_time_long
  	self.start_date.strftime('%l:%M%P')
  end

  def start_minute
  	self.start_date.strftime('%M')
  end

  # all of the same for the end date

  def end_date
  	DateTime.parse(self[:end])
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
  	self.end_date.strftime('%l%P')
  end

  def end_time_long
  	self.end_date.strftime('%l:%M%P')
  end

  def end_minute
  	self.end_date.strftime('%M')
  end
end