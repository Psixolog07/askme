Rails.application.routes.draw do
  root to: 'questions#index'
  
  resources :questions do
    patch :hide, on: :member
    patch :unhide, on: :member
  end

  resource :session, only: %i[ new create destroy ]
  resources :users, param: :nickname, except: :index
  resources :hashtags, param: :name, only: %i[ show ]
end
