# -*- coding: utf-8 -*-

dinners = [
  {
    hebrew_name: "סנדוויצ'ים",
    id: -1,
    logo: "sandwiches.jpg",
  },

  {
    hebrew_name: "פיצה רגילה",
    id: -2,
    logo: "pizza.jpg",
  },

  {
    hebrew_name: "פיצה כשרה",
    id: -3,
    logo: "kosherpizza.jpg",
  },

  {
    hebrew_name: "פיצה טיבעונית",
    id: -4,
    logo: "veganpizza.jpg",
  }
]

dinners.each do |dinner|
  rest = Restaurant.find_or_create_by(id: dinner[:id])
  rest.hebrew_name = dinner[:hebrew_name]
  rest.logo = dinner[:logo]
  rest.cp_id = dinner[:id]
  rest.counter ||= 0
  rest.last_announcement ||= Time.new(0)
  rest.save!
end
