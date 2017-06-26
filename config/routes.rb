# == Route Map
#
#        Prefix Verb   URI Pattern            Controller#Action
#        videos GET    /videos(.:format)      videos#index
#         video GET    /videos/:id(.:format)  videos#show
# session_index GET    /session(.:format)     session#index
#               POST   /session(.:format)     session#create
#       session DELETE /session/:id(.:format) session#destroy
#          root GET    /                      videos#home
# 

Rails.application.routes.draw do
  resources :videos,  only: [:index, :show]
  resources :session, only: [:index, :create, :destroy]

  root to: "videos#home"
end
