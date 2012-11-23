require 'time_diff'
class Restaurant < ActiveRecord::Base
  def timediff
    Time.diff(Time.now, last_announcement)
  end

  def name
    hebrew_name
  end
end
