Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # Route for user registration
  post '/signup', to: 'users#create'

  # Route for user login
  post '/login', to: 'sessions#create'

  resources :courses, only: [:index, :show, :create, :update, :destroy] do
    resources :course_contents, only: [:index, :create] do
      resources :reviews, only: [:index, :create]
    end
  end

  resources :course_contents, only: [:show, :update, :destroy]
  resources :enrollments, only: [:index, :show, :create, :update, :destroy]
  resources :progresses, only: [:create, :update]
  resources :reviews, only: [:show, :update, :destroy]
end
