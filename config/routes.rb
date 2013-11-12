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
# 1. faqs
# 1. credits
# 1. helps
# 
Talkinvite::Application.routes.draw do

  # Message pages (person to person, no talk)

  match '/my_messages', to: 'messages#my_messages', via: 'get'

  resources :messages do
    collection do
      get :my_messages
    end
  end

  # talks:

  # TBD:  see if we want to use named talks, using same logic as named help

  # Anonymous routes:
  match '/search', to: 'talks#search', via: 'get'
  # TBD:  why was the /posted path not working from sitemap?
  match '/posted', to: 'talks#posted', via: 'get'
  match '/start', to: 'talks#start', via: 'get'

  # Signed in routes:
  # TBD:  eliminate my_talks, now included in 'home'
  get '/my_talks', to: 'talks#my_talks'

  # Allow direct-to-talks routes, since we always have a default person:  either the current_person or anonymous
  match '/talks/new', :controller => 'talks', :action => 'new', via: 'get'
  match '/talks/search', to: 'talks#search', via: 'get'

  # TBD: why was the /talks path not working from sitemap?
  match '/talks', to: 'talks#index', via: 'get'

  # TBD:  see if we wish to nest posts, members, comments, & maps under talks
  resources :comments, :members, :posts, :maps

  # Talk pages

  # this map.connect thing might be useful, but apparently 'map' is just not found
  # map.connect "talks/:action", :controller => 'talks', :action => /[a-z]+/i
  # talks are currently nested inside people,
  #   -- but once we allow multiple 'organizers', this will no longer be true
  #   -- therefore, do not nest

  # Account & related pages:

  # services nested under poeple, may wish to shift to nested architecture for that
  # TBD:  see if we wish to nest services inside people
  resources :services
  
  # sessions:
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  resources :sessions, only: [:new, :create, :destroy]  

  # people pages: 
  # TBD: merge edit & settings
  # TBD: merge show & profile
  match '/profile', to: 'people#profile', via: 'get'
  match '/settings', to: 'people#settings', via: 'get'
  match '/signup', to: 'people#new', via: 'get'
  match '/home', to: 'people#home', via: 'get'
  
  # TBD:  kill the 'show' & 'edit' routes here? reroute 'delete' to 'inactivate'
  resources :people do

    resources :talks do
      ## collection will have lots of 'pick a talk' type pages
      # these are for a specific talk
      # TBD: eliminate all of the member routes
      member do
        get :map, :control
      end
      # these are for talks in general
      # TBD:  eliminate all of the collection routes
      collection do
        get :found, :search, :posted, :my_talks
      end
    end

    # TBD: implement 'oauth'
    # TBD: see if we need 'map'
    member do
      get :oauth, :map
    end

    # TBD: eliminate search & found
    # TBD: merge profile & edit
    # note:  'home' is the only valid option here
    collection do
      get :home, :search, :found, :profile
    end

  end

  # faqs & related

  get '/helps/new', to: 'helps#new' # otherwise new is treated as the name of a help text

  # TBD:  add a /help/page/action route?
  # note:  get is a function within the routing, to & constraints are named options to 'get'
  # note:  somehow both /help/talks_my_talks & /helps/talks_my_talks feel acceptable
  get '/help/:name', to: 'helps#help', constraints: { name: /[A-Za-z][A-Za-z0-9_]*/ }
  get '/helps/:name', to: 'helps#help', constraints: { name: /[A-Za-z][A-Za-z0-9_]*/ }

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

  root to: "static_pages#sitemap"

end
