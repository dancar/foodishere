class FoodMailer < ActionMailer::Base
  default(:from => Settings.mail_settings.from,
    :to => Settings.mail_settings.to)

  def announce(rest, comments, is_dinner)
    puts('MYDEBUG food_mailer.rb\\ 6: is_dinner: \'' + (is_dinner).to_s + '\'')
    puts('MYDEBUG food_mailer.rb\\ 7: is_dinner.class.name: \'' + (is_dinner.class.name).to_s + '\'')
    if is_dinner
      puts('MYDEBUG food_mailer.rb\\ 7: here')
      FoodMailer.announce_dinner(rest, comments)
    else
      puts('MYDEBUG food_mailer.rb\\ 10: here')
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
