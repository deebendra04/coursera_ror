Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # Route for user registration
  post '/signup', to: 'users#create'

  # Route for user login
  post '/login', to: 'sessions#create'
end
