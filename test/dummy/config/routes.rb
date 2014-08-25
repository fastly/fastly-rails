Rails.application.routes.draw do

  resources :books
  get 'books_with_session' => 'books#index_with_session'
  mount FastlyRails::Engine => "/fastly-rails"
end
