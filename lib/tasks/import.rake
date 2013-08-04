# -*- coding: utf-8 -*-
require 'json'
require 'fetch_rests'

desc "Fetch and update rests from CP"
task :update_rests => :environment do
  FoodIsHere::fetch_rests.each do |r|
    add_rest(r, "http://couponphone.co.il/")
  end
end

def add_rest(rest, logo_prefix = "")
  r = Restaurant.find_by_cp_id(rest["RestaurantID"])
  unless r
    r = Restaurant.create do |r|
      r.hebrew_name = rest["RestaurantName"]
      r.logo = logo_prefix + rest["RestaurantLogo"]
      r.cp_id = rest["RestaurantID"]
      r.last_announcement = Time.new(0)
      r.counter = 0
    end
    puts "created #{r.inspect}"
  end
end
