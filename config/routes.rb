ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'Dashboard', :action => 'show'
  
  map.resource :dashboard
  map.resources :conversions
  map.resources :comments
  map.resources :polls
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
