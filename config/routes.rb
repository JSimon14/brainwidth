Brainwidth::Application.routes.draw do
  devise_for :users
  root "tasks#index"
  resources :tasks
end
