Rails.application.routes.draw do
  root to: 'questions#index'
  resources :questions
  patch '/questions/1/hide', to: 'questions#hide'
  resources :users
end
