# == Route Map
#
#        Prefix Verb URI Pattern          Controller#Action
#        signin GET  /signin(.:format)    account#signin
#       process POST /signin(.:format)    account#process
#       signout GET  /signout(.:format)   account#signout
#   watch_video GET  /watch/:id(.:format) video#watch
# video_listing GET  /                    video#listing
# 

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/signin",    to: "account#signin",			as: 'signin'
  post "/signin",   to: "account#process",		as: 'process'
  get "/signout",   to: "account#signout",		as: 'signout'

  get "/watch/:id", to: "video#watch",				as: 'watch_video'
  root 							to: "video#listing",			as: 'video_listing'
end
