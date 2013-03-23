require "net/http"
require 'json'
module FoodIsHere

  def self.fetch_rests
    http = Net::HTTP.new("couponphone.co.il", 80)
    initial_response = http.get("/")
    cookie = initial_response["set-cookie"].split(";")[0]

    data = {
      "__EVENTTARGET" =>"",
      "ctl00$txbUserName" => ENV["CP_UN"],
      "ctl00$txbPassword" => ENV["CP_PW"],
      "SearchType" =>"0"
    }.to_a.map {|x| x.join("=")}.join("&")
    login_response = http.post("/", data)

    cookie = login_response["set-cookie"].split(";")[0]
    rests_response = http.post("/Home/Default.aspx/GetRestaurantList", '{"NextRound":"11:00"}',
      {
        "Cookie" => cookie,
        "Content-Type" => "application/json; charset=UTF-8"
      }
    )
    rests = JSON.parse(rests_response.body)["d"]
    rests
  end
end
