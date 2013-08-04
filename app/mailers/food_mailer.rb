class FoodMailer < ActionMailer::Base
  default(:from => Settings.mail_settings.from,
    :to => Settings.mail_settings.to)

  def announce(rest, comments, is_dinner)
    if is_dinner
      FoodMailer.announce_dinner(rest, comments)
    else
      FoodMailer.announce_food(rest, comments)
    end
  end

  def announce_food(rest, comments)
    @rest = rest
    @comments = comments
    @subject = "[Food] #{rest.hebrew_name}"

    mail(
      subject: @subject,
    ).deliver
  end

  def announce_dinner(rest, comments)
    @rest = rest
    @comments = comments
    @subject = "[Food] (Dinner!) #{rest.hebrew_name}"

    mail(
      subject: @subject,
    ).deliver
  end

end
