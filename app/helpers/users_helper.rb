module UsersHelper

  def get_hours(asleep_length)
    asleep_length/60/60
  end

  def get_minutes(asleep_length)
    asleep_length/60%60
  end

  def add_leading_zero(time)
    time.to_s.gsub(/\A(\d)\z/, '0\1')
  end

  def time_now
    Time.now.to_i
  end

  def did_user_sleep_last_night?
    (time_now - @sleep_time) < (24*60*60)
  end

  def trigger_time(num)
    case num
    when 9, 10, 11
      (Time.now.beginning_of_day - (60*60*(12-num))).to_i
    when 12
      (Time.now.beginning_of_day).to_i
    when 1, 2, 3, 4, 5, 6, 7
      (Time.now.beginning_of_day + (60*60*num)).to_i
    end
  end



end