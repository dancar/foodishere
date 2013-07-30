Foodishere::Application.routes.draw do
  get "home/index"
  get 'announce' => 'home#announce'
  get 'logout' => 'home#logout'
  root :to => "home#index"
  resource :session
end
