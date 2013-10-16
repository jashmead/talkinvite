# routes.rb functions as a de facto map of the system

Talkinvite::Application.routes.draw do

  resources :attachments

  resources :tags

  resources :messages

  resources :socials

  resources :venues

  resources :notifications

  resources :migrations

  resources :comments

  resources :members

  ## put most specific routes at the top:

  # have start point to a static page route, 
  #   which then sends you to 
  #     'talks/my_talks' if you are
  #     'talks/gottalk' if you are not

  match '/start', to: 'talks#start', via: 'get'

  match '/settings', to: 'people#edit', via: 'get'
  match '/profile', to: 'people#show', via: 'get'
  match '/signup', to: 'people#new', via: 'get'
  
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  get "people/home"

  match '/home', to: 'people#home', via: 'get'

  ## Static pages:
  get "static_pages/about"
  get "static_pages/contact"
  get "static_pages/credits"
  get "static_pages/help"
  get "static_pages/menu"
  get "static_pages/privacy"

  ## get rid of home, once followers are on a people page
  get "static_pages/home"

  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/credits', to: 'static_pages#credits', via: 'get'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/menu', to: 'static_pages#menu', via: 'get'
  match '/privacy', to: 'static_pages#privacy', via: 'get'
  match '/home', to: 'static_pages#home', via: 'get'

  ## map.connect "talks/:action", :controller => 'talks', :action => /[a-z]+/i

  resources :people do
    ## member will give paths of the form:  /people/1/following, /people/1/followers
    ## actions are following, followers
    ## paths are following_people_path(id), followers_people_path(id)
    ##  i.e. people/1/following
    member do
      get :following, :followers
    end
    collection do
      get :search, :found, :recent, :nearby
    end
  end

  match '/recent', to: 'talks#recent', via: 'get'
  match '/nearby', to: 'talks#nearby', via: 'get'
  match '/my_talks', to: 'talks#my_talks', via: 'get'

  resources :sessions, only: [:new, :create, :destroy]  

  resources :talks do
    ## collection will have lots of 'pick a talk' type pages
    collection do
      get :start, :search, :found, :gottalk, :my_talks
    end
  end

  resources :relationships, only: [:create, :destroy]

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

  root to: "talks#start"

end
