RailsApp::Application.routes.draw do
  get '/register' => 'users#new', :as => 'register'
  get '/login' => 'sessions#new', :as => 'login'
  get '/logout' => 'sessions#destroy', :as => 'logout'

  resources :events, :media, :sessions, :users

  get '/push/google' => 'push#google'
  get '/users/verify' => 'users#verify', :as => 'user_verification'
  get '/about' => 'pages#about', :as => 'about'
  get '/bylaws' => 'pages#bylaws', :as => 'bylaws'
  get '/contact' => 'pages#contact', :as => 'contact'
  get '/join' => 'pages#join', :as => 'join'
  get '/conference' => 'pages#conference', :as => 'conference'
  get '/conference_register' => 'pages#conference_register', :as => 'conference_register'
  get '/pledge_signup' => 'pages#pledge_signup', :as => 'pledge_signup'
  get '/test'  => 'pages#test'
  get '/' => 'pages#index', :as => 'root'
end
