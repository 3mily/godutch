Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'static#test'
  get '/about', to: 'static#about', as: 'about'
  get '/events/details', to: 'events#details', as: 'events_details'
  get '/events/confirmation', to: 'events#confirmation', as: 'attendeesconfirm'
  get '/events/invite', to: 'static#error', as: 'wrong_way'
  post 'payments/new/:id', to: 'payments#create', id: /\d+/
  get 'payments/new/:id', to: 'payments#new', as: 'new_payment', id: /\d+/
  get 'session/destroy', to: 'sessions#destroy', as: 'logout'
  get '/contacts', to: 'contacts#new'
  resources :users, only: [:new, :create, :update, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :events, only: [:new, :create, :update, :destroy]
  resources :cards, only: [:create, :destroy]
  resources :payments, only: [:new, :create]
  resources :attendees, only: [:create]
  resources :contacts, only: [:new, :create, :update, :destroy]

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
