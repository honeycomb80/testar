Rails.application.routes.draw do
  get 'pages/index'

  root 'pages#index'
  
  get '/graph', to: 'pages#graph'
  post '/graph', to: 'pages#graph'
end

#      Prefix Verb URI Pattern            Controller#Action
# pages_index GET  /pages/index(.:format) pages#index
#        root GET  /                      pages#index
#      search GET  /search(.:format)      pages#index
#             POST /search(.:format)      pages#index
