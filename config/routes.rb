Foodishere::Application.routes.draw do
  get "home/index"
  match 'announce' => 'home#announce'
  match 'logout' => 'home#logout'
  root :to => "home#index"
  resource :session
end
