Rails.application.routes.draw do
  resources :friendships, only:[:create, :destroy]
  get 'channel', to: 'channel#private_channel', as: "private_channel"
  root 'chatroom#index'
  get 'login' , to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'message', to: 'messages#create'
  get 'friends', to: 'friends#index'
  get 'search_friend', to: 'friends#search'
  post 'toggle_family', to: 'friends#toggle_family'
  post 'private_channel/:friend', to: 'messages#message_private', as: "private_message"
  mount ActionCable.server, at: '/cable'
end
