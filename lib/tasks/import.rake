require 'json'

JSON_SOURCE = File.join(Rails.root, "rests.json")
task :import => :environment do
  source_json = ENV["SOURCE"] || JSON_SOURCE
  imported = JSON.load(File.open(source_json))
  imported["d"].each do |rest|
    r = Restaurant.find_by_cp_id(rest["RestaurantID"])
    unless r
      r = Restaurant.create do |r|
        r.hebrew_name = rest["RestaurantName"]
        r.logo = rest["RestaurantLogo"]
        r.cp_id = rest["RestaurantID"]
        r.last_announcement = Time.now
        r.counter = 0
      end
      puts "created #{r.inspect}"
    end
  end
end
