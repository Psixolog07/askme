Rails.application.routes.draw do
  root to: 'questions#index'
  
  resources :questions do
    patch :hide, on: :member
    patch :unhide, on: :member
  end

  resources :users
end
