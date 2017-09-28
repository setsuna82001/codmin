Rails.application.routes.draw do
  #=====================================
  root 'contents#index'

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
  post  '/contents/search'  => 'contents#search'

  #=====================================
  # POST: /api/search
  #=====================================
  post  '/api/search' => 'contents#dmmsearch'
end
