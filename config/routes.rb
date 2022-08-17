Rails.application.routes.draw do
  root to: 'questions#index'
  
  resources :questions do
    patch :hide, on: :member
    patch :unhide, on: :member
  end

  resource :session, only: %i[new create destroy]
  resources :users, only: %i[new create]
end
