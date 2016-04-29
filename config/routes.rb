Brainwidth::Application.routes.draw do
  devise_for :users
  root "tasks#index"
  resources :tasks, only: [:new, :create, :show, :edit, :update]
end
