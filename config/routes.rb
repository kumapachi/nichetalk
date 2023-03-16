Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions'}
  root to: "topics#index"
  # get 'topics/index'
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'messages/index'
  resources :users, only: [:edit, :update]
  resources :topics
  resources :rooms, only: [:new, :create, :destroy] do
    resources :messages, only: [:index, :create]
  end
end
