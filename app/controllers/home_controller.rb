require 'json'

class HomeController < ApplicationController
  def index
    @showing_all = params["all"]
    if @showing_all
      @rests_raw = Restaurant.all
    else
      @rests_raw = Restaurant.where(delivery_expected: true)
    end
    @rests = {}
    @rests_raw.each do |rest|
      @rests[rest.id] = rest.to_client_format
    end

    if dinner_time?
      @dinner_rests = get_todays_dinner_rests
      @dinner_rests.each do |dinner|
        @rests[dinner.id] = dinner.to_client_format
      end

      # Remove dinner rests from normal rests:
      dinner_ids = @dinner_rests.map &:id
      @rests_raw.reject! do |rest|
        dinner_ids.include? rest.id
      end
    end
  end

  def announce
    rest = Restaurant.find_by_id(request.parameters["rest_id"])
    comments = request.parameters["comments"]
    is_dinner = request.parameters["dinner"] == "true"
    raise "Restaurant not found with id=#{request.parameters["rest_id"]}" unless rest
    if rest.last_announcement > Settings.digest_period.minutes.ago
      head :no_content
      return
    end
    rest.counter += 1
    rest.last_announcement = Time.now
    FoodMailer.announce(rest, comments, is_dinner)
    rest.save
    head :no_content
  end

  private

  def dinner_time?
    dinner_time = Time.parse("#{Settings.dinners.dinner_time} #{Settings.dinners.timezone}")
    Time.now > dinner_time
  end

  def get_todays_dinner_rests
    today = Time.now.strftime("%A")
    todays_dinners_ids = Settings.dinners.weekly_menu[today]
    Restaurant.order("id DESC").find(todays_dinners_ids)
  end

end
