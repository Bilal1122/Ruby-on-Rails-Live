Rails.application.routes.draw do
  devise_for :users
  get 'rooms/show'
  resources :chats, only: [:index, :create, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  root 'chats#index'
  get 'switch_user' => 'switch_user#set_current_user'
  get '*path' => redirect('/')
end
