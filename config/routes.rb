Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions'}
  root to: "topics#index"
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'messages/index'
  get 'rooms/index'
  resources :users, only: [:edit, :update]
  resources :rooms, only: [:new, :create, :destroy] do
    resources :messages, only: [:index, :create]
  end
  resources :topics
end
