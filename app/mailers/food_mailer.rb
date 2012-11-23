class FoodMailer < ActionMailer::Base
  default from: Settings.mail_settings.from, to: Settings.mail_settings.to
  def announce_food(rest, user)
    @rest = rest
    @announcer = "#{user.first_name} #{user.last_name}"
    @announcer = user.email.split["@"][0] if @announcer.strip.empty?
    @announcer_email = user.email
    @subject = "[Food] #{rest.hebrew_name}"
    mail(:subject => @subject).deliver
  end
end
