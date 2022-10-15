Rails.application.routes.draw do
  resources :friendships, only:[:create, :destroy]
  root 'chatroom#index'
  get 'login' , to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'message', to: 'messages#create'
  get 'friends', to: 'friends#index'
  get 'search_friend', to: 'friends#search'
  post 'toggle_family', to: 'friends#toggle_family'
  get 'private_chat', to: 'chatroom#private'
  mount ActionCable.server, at: '/cable'
end
