Foodishere::Application.routes.draw do
  get "home/index"
  get 'announce' => 'home#announce'
  root :to => "home#index"
end
