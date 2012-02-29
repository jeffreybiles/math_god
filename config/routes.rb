TestStuff::Application.routes.draw do

  match '/unfinished_business', to: 'images#unfinished_business'

  resources :player_logs
  match "/current_player_logs", to: 'player_logs#current_player_logs'
  match "/current_player_logs/:id", to: 'player_logs#current_player_logs'

  resources :my_qualities
  match "/show_my_qualities", to: 'my_qualities#show_mine'
  match "/show_my_qualities/:id", to: 'my_qualities#show_mine'

  resources :rewards

  resources :requirements

  resources :links

  resources :storylets
  match "/storylets/:id/action", to: 'storylets#action'
  match "/storylets/:id/failure/:created_at", to: 'storylets#failure'
  match "/storylets/:id/success/:created_at", to: 'storylets#success'

  resources :qualities

  resources :event_changes

  resources :event_requirements
  match '/event_requirements/:id/edit/quest', to: 'event_requirements#quest_form'
  match '/event_requirements/:id/edit/choice', to: 'event_requirements#choice_form'

  resources :happenings

  resources :events

  resources :item_requirements
  match '/item_requirements/:id/edit/quest', to: 'item_requirements#quest_form'
  match '/item_requirements/:id/edit/choice', to: 'item_requirements#choice_form'


  resources :item_rewards

  resources :owned_items

  resources :items

  resources :reputation_requirements
  match '/reputation_requirements/:id/edit/quest', to: 'reputation_requirements#quest_form'
  match '/reputation_requirements/:id/edit/choice', to: 'reputation_requirements#choice_form'


  resources :blessing_requirements
  match '/blessing_requirements/:id/edit/quest', to: 'blessing_requirements#quest_form'
  match '/blessing_requirements/:id/edit/choice', to: 'blessing_requirements#choice_form'

  resources :RequirementsController

  resources :rep_gains

  resources :consequences

  resources :reputations

  resources :factions

  resources :locations
  match '/locations', to: 'locations#index'

  resources :universes

  resources :images

  resources :choices
  match '/choices/:id/:blessing_id', to: 'choices#success'
  match '/quests/:quest_id/new_choice', to: 'choices#new'

  resources :quests
  match '/quests/:id/info', to: 'quests#info'
  match '/quests/:id/quest_choices', to: 'quests#quest_choices'
  match '/quests/:id/choices', to: 'quests#choices'

  resources :users
  resources :user_sessions
  match '/signout', to: 'user_sessions#destroy'
  match '/display_second_step', to: 'users#display_second_step'
  match '/second_step', to: 'users#second_step'

  resources :blessings
  match '/blessings/:id/info', to: 'blessings#info'

  resources :gods
  match '/gods/:id/quests', to: 'gods#quests'


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
