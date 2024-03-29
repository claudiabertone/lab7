SWorD::Application.routes.draw do



  # route for the homepage
  root :to => 'pages#home'

  # named routes for static pages and signup
  match '/home', to: 'pages#home'
  match '/about', to: 'pages#about'
  match '/contact', to: 'pages#contact'
  match '/faq', to: 'pages#faq'
  match '/signup',  to: 'users#new'
  match '/signin', to: 'sessions#new'
  # signout should be performed by using the HTTP DELETE request
  match '/signout', to: 'sessions#destroy', via: :delete


  # default routes for the Users controller
  resources :users   #nuova route per gestire le risorse messe a disposizione dal modello degli utenti e dal suo controllore. ed route per generare URI legati agli utenti


  # default routes for the Session controller
  resources :sessions, only: [:new, :create, :destroy]  #nuova route per gestire le risorse messe a disposizione dal sessions e dal suo controllore. ed route per generare URI legati alla sessions


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
