Brainwidth::Application.routes.draw do
  devise_for :users
  root "tasks#index"
  resources :categories do
    resources :tasks
  end
end
