Incubator107::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :locations

  #root to: 'city#index'
  #get "home/index"

  resources :events
  #  scope "(:locale)", :locale => /en|ro/ do

 
  #get "cities/new"
  #get "static_pages/home"
  #get "static_pages/help"

  post '/tinymce_assets' => 'tinymce_assets#create'  

  

  constraints(Subdomain) do
    resources :articles
    resources :groups
    resources :news
    resources :partners
    resources :workshops
    resources :workshop_requests
    # resources :password_resets
    # resources :sessions, only: [:new, :create, :destroy]
 
    # match '/signin', to: 'sessions#new', via: 'get'
    # match '/signout', to: 'sessions#destroy', via: :delete
    # match '/signup', to: 'users#new', via: 'get'


    match '/profile/:id', to: 'users#edit_profile', via: 'get', as: "profile"
    match '/profile/:id', to: 'users#update_profile', via: 'patch'

    match '/workshops/:id/signup', to:	"workshops#signup", via: 'post', as: "workshop_signup"
    match '/contact', to: "contact#show", via: 'get'
    root to: 'home#index'
    match '/calendar', to: 'calendar#show', via: 'get'
    match '/verify', to: "person#verify", via: 'get'        
  end

  match '/subscribe_newsletter', to: 'subscriber#register_newsletter', via: 'post'
  get "/" => 'city#index'
  
  # end

  #root :to =>get "home#index"

  # The priority is based upon order of creation: first created -> highest priority.
  #
  # See how all your routes lay out with "rake routes".

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
