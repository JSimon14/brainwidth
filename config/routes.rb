Brainwidth::Application.routes.draw do
  devise_for :users
  root "tasks#index"
  resources :categories
  resources :tasks
end
