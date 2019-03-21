Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "user/registrations"}
  devise_for :installs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :users, only: [:show]
  resources :friendships
  
  root 'welcome#index' 
  get 'my_portfolio' => 'users#my_portfolio'
  
  get 'search_stocks' => 'stocks#search'
  
  resources :user_stocks, only: [:create, :destroy] # add stock to your list
  
  get 'my_friends' => 'users#my_friends'
  get 'search_friends' => 'users#search'
  post 'add_friend' => 'users#add_friend' 
end
