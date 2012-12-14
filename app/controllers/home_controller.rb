require 'json'
require 'pp'
class HomeController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :get_user
  def index
    @rests_raw = Restaurant.order("counter DESC, hebrew_name ASC").all
    @rests = {}
    @rests_raw.each do |rest|
      @rests[rest.id] = {
        name: rest.hebrew_name.html_safe,
        imgSrc: rest.logo,
        announced_recently: rest.is_recent
      }
    end
  end

  def announce
    @rest = Restaurant.find_by_id(request.parameters["rest_id"])
    raise "Restaurant not found with id=#{request.parameters["rest_id"]}" unless @rest
    @rest.counter += 1
    @rest.last_announcement = Time.now
    @rest.save
    FoodMailer.announce_food(@rest, @user)
  end

  def logout
    reset_session
    redirect_to root_path
  end

  private
  def get_user
    @user = User.find(session[:user_id])
    raise "Invalid user" unless @user
  end
end
