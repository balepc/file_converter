ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.root :controller => 'conversions', :action => 'index'
    admin.resources :conversions
  end
  
  map.root :controller => 'Dashboard', :action => 'show'
  
  map.resource :dashboard
  map.resources :conversions
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  
end
