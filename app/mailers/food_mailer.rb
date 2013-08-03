class FoodMailer < ActionMailer::Base
  def announce_food(rest, comments)
    @rest = rest
    @comments = comments
    @subject = "[Food] #{rest.hebrew_name}"

    mail(
      subject: @subject,
      from: Settings.mail_settings.from,
      to: Settings.mail_settings.to
    ).deliver
  end
end
