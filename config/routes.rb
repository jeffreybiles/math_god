TestStuff::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" }
  match '/welcome' => "user_sessions#create", :as => :user_root

  match '/unfinished_business', to: 'images#unfinished_business'

  resources :player_logs
  match "/current_player_logs", to: 'player_logs#current_player_logs'
  match "/current_player_logs/:id", to: 'player_logs#current_player_logs'
  match "/special_storylets", to: 'player_logs#special_storylets'
  match "/special_storylets/:id", to: 'player_logs#special_storylets'
  match "/storylet_show/:id", to: 'player_logs#storylet_show'

  resources :my_qualities
  match "/show_my_qualities", to: 'my_qualities#show_mine'
  match "/show_my_qualities/:id", to: 'my_qualities#show_mine'
  match "/my_gods", to: 'my_qualities#my_gods'
  match "/my_gods/:id", to: 'my_qualities#my_gods'
  resources :rewards

  resources :requirements

  resources :links

  resources :storylets
  match "/storylets/:id/action", to: 'storylets#action'
  match "/storylets/:id/failure/:created_at", to: 'storylets#failure'
  match "/storylets/:id/success/:created_at", to: 'storylets#success'

  resources :qualities

  resources :universes

  resources :images

  resources :users
  resources :user_sessions
  match '/signout', to: 'user_sessions#destroy'
  match '/display_second_step', to: 'users#display_second_step'
  match '/second_step', to: 'users#second_step'



  root to: 'user_sessions#intro_page'
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
  # match ':controller(/:action(/:id(.:format)))'
end
