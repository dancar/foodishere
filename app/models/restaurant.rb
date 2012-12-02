require 'time_diff'
class Restaurant < ActiveRecord::Base
  def is_recent
    (Time.now.to_i - last_announcement.to_i) < 60 * 60 * 3
  end

  def name
    hebrew_name
  end
end
