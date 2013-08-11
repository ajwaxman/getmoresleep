module UsersHelper

  def asleep_hours(asleep_length)
    asleep_length/60/60
  end

  def asleep_minutes(asleep_length)
    asleep_length/60%60
  end

  def format_minutes(time)
    time.to_s.gsub!(/\A(\d)\z/, '0\1')
  end

end