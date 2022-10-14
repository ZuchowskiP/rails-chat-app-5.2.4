Rails.application.routes.draw do
  resources :friendships, only:[:create, :destroy]
  root 'chatroom#index'
  get 'login' , to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'message', to: 'messages#create'
  get 'friends', to: 'friends#index'
  get 'search_friend', to: 'friends#search'


  mount ActionCable.server, at: '/cable'
end
