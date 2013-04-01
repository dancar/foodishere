require 'mechanize'

module FoodIsHere
  class Orders
    def self.fetch_orders
      agent = Mechanize.new
      login_page = agent.get("http://www.couponphone.co.il")
      login_form = login_page.forms.first
      login_form["ctl00$txbUserName"] = ENV["CP_UN"]
      login_form["ctl00$txbPassword"] = ENV["CP_PW"]
      login_button = login_form.button_with(value: "OK")
      login_form.submit(login_button)
      sent_orders_page = agent.get("http://www.couponphone.co.il/OrderStatus/LoadSentOrders.aspx")
      rests_ids = sent_orders_page.forms.first.fields_with(id: "hdfRestaurantID").map{|field| field.value}
      rests_ids
    end
  end
end
