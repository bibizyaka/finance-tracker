Rails.application.routes.draw do
  devise_for :users
  devise_for :installs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'welcome#index' 
  get 'my_portfolio' => 'users#my_portfolio'
  
  get 'search_stocks' => 'stocks#search'
end
