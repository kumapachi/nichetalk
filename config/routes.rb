Rails.application.routes.draw do
  get 'topics/index'
  root to: "topics#index"
end
