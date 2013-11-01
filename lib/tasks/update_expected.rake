require 'fetch_orders'

desc "Update which restaurants are expected to deliver"
task :update_expected => :environment do
  ids = FoodIsHere::Orders.fetch_orders
  ActiveRecord::Base.transaction do
    Restaurant.all.each do |rest|
      rest.delivery_expected = ids.include?(rest.cp_id.to_s)
      rest.save
    end
  end

end
