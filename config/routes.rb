Rails.application.routes.draw do
  resources :chats
  devise_for :users, controllers: {
  omniauth_callbacks: "omniauth_callbacks"
}
  root 'homes#index' 
end
