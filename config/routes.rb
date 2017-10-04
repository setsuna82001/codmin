Rails.application.routes.draw do

  #=====================================
  # Root
  #=====================================
  root 'contents#index'

  #=====================================
  # GET:  /users      => users#index
  # GET:  /users/new  => users#new
  # POST: /users      => users#create
  # GET:  /users/:id  => users#show
  # GET:  /users/:id/edit => users#edit
  # PUT:  /users/:id  => users#update
  # DEL:  /users/:id  => users#destroy
  #=====================================
  resources :users

  #=====================================
  # GET:  /sessions     => user_sessions#index
  # GET:  /sessions/new => user_sessions#new
  # POST: /sessions     => user_sessions#create
  # GET:  /sessions/:id => user_sessions#show
  # GET:  /sessions/:id/edit  => user_sessions#edit
  # PUT:  /sessions/:id => user_sessions#update
  # DEL:  /sessions/:id => user_sessions#destroy
  #=====================================
  resources :sessions,  controller: :user_sessions

  #=====================================
  # login/logout
  #=====================================
  get   'login'   => 'user_sessions#new',     as: :login
  get   'logout'  => 'user_sessions#destroy', as: :logout

  #=====================================
  # GET:  /contents     => contents#index
  # GET:  /contents/new => contents#new
  # POST: /contents     => contents#create
  # GET:  /contents/:id => contents#show
  # GET:  /contents/:id/edit  => contents#edit
  # PUT:  /contents/:id => contents#update
  # DEL:  /contents/:id => contents#destroy
  #=====================================
  resources :contents

  #=====================================
  # tag/author list
  #=====================================
  get   '/contents/list/:type/:name' => 'contents#list'

  #=====================================
  # tag/author search
  #=====================================
  # TODO future
  #post  '/contents/search'  => 'contents#search'

  #=====================================
  # POST: /api/search
  #=====================================
  post  '/api/search' => 'contents#dmmsearch'
end
