Rails.application.routes.draw do

  resources :books
  mount FastlyRails::Engine => "/fastly-rails"
end
