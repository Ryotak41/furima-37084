Rails.application.routes.draw do
  devise_for :users
  #get 'items/index'
  root to: 'items#index'
  #post 'items/new'
  resources :items, only: [:index, :new, :create, :show, :edit, :update]
end
