ActionController::Routing::Routes.draw do |map|
  map.resources :userrights, :except => [:edit, :update]
  map.resources :rights
  map.resources :users
  map.resources :sessions, :only => [:new, :create, :destroy]
  map.resources :partyroles
  map.resources :roles
  map.resources :occupationclassifications
  map.resources :incomeclassifications
  map.resources :people , :except => [:show]
  
  map.connect 'people/:party_id', :controller => 'people', :action => 'show'
  map.connect 'people/search/*', :controller => 'people', :action => 'search'
  map.connect 'people/search_classi/*', :controller => 'people', :action => 'search_classi'
  
  map.connect 'pages/select_view', :controller => 'pages', :action => 'select_view'
  map.connect 'pages/sign_in', :controller => 'pages', :action => 'sign_in'
  map.connect 'pages/rights', :controller => 'pages', :action => 'rights'
  map.connect 'pages/income_classes', :controller => 'pages', :action => 'income_classes'
  map.connect 'pages/occupation_classes', :controller => 'pages', :action => 'occupation_classes'
  map.connect 'pages/roles', :controller => 'pages', :action => 'roles'
  map.connect 'pages/people', :controller => 'pages', :action => 'people'
  map.connect 'pages/people_search', :controller => 'pages', :action => 'people_search'
  map.connect 'pages/users', :controller => 'pages', :action => 'users'
  
  map.resources :parties
  
  map.help   '/help',   :controller => 'pages', :action => 'help'
  map.signin '/signin',   :controller => 'sessions', :action => 'new'
  map.signout '/signout', :controller => 'sessions', :action => 'destroy'
  
  map.search_form 'search_form', :controller => 'people', :action => 'search_form'  # map.search_form ... -> creates a URL helper -> search_form_path
  
  
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  
  map.root :controller => 'pages', :action => 'home' 

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
  
end
