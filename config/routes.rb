ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.root :controller => 'conversions', :action => 'index'
    admin.resources :conversions
    admin.resources :assets, :member => {:download => :get}
    admin.resources :users
    admin.resources :conv_requests
  end
  
  map.root :controller => 'Assets', :action => 'new'
  
  map.resources :conversions
  map.resources :conv_requests
  map.resources :assets, :member => {:convert => :post}
  map.resources :banners, :member => {:click => :get}
  
  map.connect '/request', :controller => 'ConvRequests', :action => 'new'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
