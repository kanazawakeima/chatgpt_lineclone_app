Rails.application.routes.draw do
  resources :teams, only: [:new, :create, :destroy]
  resources :chats
  devise_for :users, controllers: {
  omniauth_callbacks: "omniauth_callbacks"
}
  root 'chats#index' 
end
