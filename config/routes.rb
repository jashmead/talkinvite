# routes.rb functions as a de facto map of the system
#   -- put most specific routes at the top:
#   -- 10/31/13 -- checked that all routes have a controller 
#     -- & that all controller actions are internal or have a route
#
# main entry points are:
# 1. talk pages:  new, edit, my talks, search 
# 1. account pages:  profile, edit settings
# 1. session pages:  signin, signout
# 1. maps:  add map, change, save
# 1. member pages:  join (& regrets)
# 1. posts: announce (also change, cancel, mark done)
# 1. services: setup services for use in posts
# 1. comments: add comments to talk
# 1. messages:  talk to other talkers
# 1. static pages:  about, contact, privacy
# 1. faqs (& credits & help & bug report):  list, search, show
# 
# could also build a 'sitemap', basically the pages that don't require you to specify a record,
#   -- possibly with signed in & not signed in versions
#   -- there is a great icon for this in the font-awesome set

Talkinvite::Application.routes.draw do

  # Message pages (person to person, no talk)

  resources :messages

  # talks:

  match '/my_talks', to: 'talks#my_talks', via: 'get'
  match '/search', to: 'talks#search', via: 'get'
  match '/active', to: 'talks#active', via: 'get'
  match '/start', to: 'talks#start', via: 'get'

  #   these are all nested under talks, so might want to go the nested resource route
  # TBD:  see if we wish to nest posts, members, comments, & maps under talks

  resources :comments, :members, :posts, :maps

  # Talk pages

  # this map.connect thing might be useful, but apparently 'map' is just not found
  # map.connect "talks/:action", :controller => 'talks', :action => /[a-z]+/i
  # talks are currently nested inside people,
  #   -- but once we allow multiple 'organizers', this will no longer be true
  #   -- therefore, do not nest

  resources :talks do
    ## collection will have lots of 'pick a talk' type pages
    member do
      get :map, :control
    end
    collection do
      ## 'my_talks' uses current account to select set of talks, doesn't need to be member resource
      get :found, :my_talks, :search, :active
    end
  end

  # Account & related pages:

  # services nested under poeple, may wish to shift to nested architecture for that
  # TBD:  see if we wish to nest services inside people
  resources :services
  
  # sessions:
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  resources :sessions, only: [:new, :create, :destroy]  

  # people pages: 
  match '/profile', to: 'people#profile', via: 'get'
  match '/settings', to: 'people#settings', via: 'get'
  match '/signup', to: 'people#new', via: 'get'
  match '/home', to: 'people#home', via: 'get'
  
  resources :people do
    member do
      get :oauth, :map
    end
    collection do
      get :home, :search, :found, :profile
    end
  end

  # faqs & related
  # TBD: add in a route of the form /help/faqs and so on, i.e. /help/page_name, then put at bottom right corner of each page

  # get '/help/:name', to 'helps#by_name'

  resources :helps, :faqs, :credits

  ## Static pages:

  get "static_pages/about"
  get "static_pages/contact"
  get "static_pages/privacy"
  get "static_pages/sitemap"

  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/privacy', to: 'static_pages#privacy', via: 'get'
  match '/sitemap', to: 'static_pages#sitemap', via: 'get'

  # match '/teapot', to: 'static_pages#teapot', via: 'get'

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
