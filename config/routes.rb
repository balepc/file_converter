ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.root :controller => 'conversions', :action => 'index'
    admin.resources :conversions
  end
  
  map.root :controller => 'Assets', :action => 'new'
  
  map.resources :conversions
  map.resources :assets, :member => {:convert => :post}
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
