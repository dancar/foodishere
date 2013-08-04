require 'time_diff'
class Restaurant < ActiveRecord::Base
  default_scope order("hebrew_name ASC")

  def is_recent
    (Time.now.to_i - last_announcement.to_i) < 60 * 60 * 3
  end

  def name
    hebrew_name
  end

  def to_client_format
    {
      name: self.name.html_safe,
      imgSrc: self.logo,
      announced_recently: self.is_recent
    }
  end
end
