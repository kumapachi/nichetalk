Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions'}
  root to: "topics#index"
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'messages/index'
  get 'rooms/index'
  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  end
  resources :rooms, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :messages, only: [:index, :create]
    get :follows,   on: :member
    get :followers, on: :member
  end
  resources :topics
  mount ActionCable.server => '/cable'
end
