## TBD:
##  get start, about, contact up

# routes.rb functions as a de facto map of the system

# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

=begin

  Tables:
    attachments -- to better work with postgres, polymorphic up to locations, people, posts, talks, tweets
    calendar -- like sessions, a materialized view, includes range, scale, current date (cx)
    connections -- talk to talk, from/to (t2t?)
    locations -- better as places?
    maps -- like sessions, a materialized view, includes bounding box, focus, probably some other stuff
    messages -- user to user messages, in re whatever they like.
    notifications? abstraction layer for tweets & other broadcasts
    people -- the source of all difficulties
    posts -- posts attached to a talk, also includes join, leave, as well as default comment
    relationships -- person to person, from/to
    schema_migrations -- rails table
    sessions -- used by tutuorial
    tags  -- will include ratings, polymorphic up to all core tables locations, people, posts, talks, tweets (tx)
    talks -- the raison de etre of the system

  Core
    people
    talks
    locations

  Near Core
    posts
    messages
    notifications
    tweets

  Paths in addition to the usual 7
    map
    calendar
    circles (subclass of SVG)

  Linkages
    relationships
    connections (talk2talk?)
    -- location to location, not yet, if ever

  Materialized views:
    maps
    calendars
    sessions
    circles?
      -- start, next, & so on

  Static

  Accounts
    signup
    signin
    signout
    close account
    settings
    profile -- public face
    home -- start point for signed in users

  Talk searches
    search (of talkinvite)
    topic
    nearby
    trending (twitter)
    mytalks
    circles
    categories:  sports, weather, movies, fashion, politics, news, ...
      -- google searches

  Dev Strategy:
    add a table, view type, other functionality at a step
=end

Talkinvite::Application.routes.draw do

  ## kill calendars & maps in a bit, once 8 & 9 are done
  # model attachments on ABAI, use their triggers! 
  #   and either their code or one of the gems that does this, 
  #   i.e. paperclip, see polymorphic section in guides
  # tweets specialized
  # tags specialized
  #   see tags, calendars, maps, contacts in OSX Maverick
  # talk pages
  #   build up using microposts as a model
  #   microposts only use create/destroy, but we see talks as first class objects in own right
  ## add in users/name with instructions to locate id & then route to it
  ## do subscribe via a link from the header (as indicated); do unsubscribe from settings page
  ## to add '/people/search', do we need to do anything?

  ## put most specific routes at the top:

  match '/settings', to: 'people#edit', via: 'get'
  match '/profile', to: 'people#show', via: 'get'
  match '/signup', to: 'people#new', via: 'get'
  
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  ## Static pages:
  get "static_pages/about"
  get "static_pages/contact"
  get "static_pages/credits"
  get "static_pages/help"
  get "static_pages/menu"
  get "static_pages/privacy"
  get "static_pages/home"

  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/credits', to: 'static_pages#credits', via: 'get'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/menu', to: 'static_pages#menu', via: 'get'
  match '/privacy', to: 'static_pages#privacy', via: 'get'
  match '/gottalk', to: 'talks#start', via: 'get'
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
      get :search, :found, :recent, :nearby, :my_talks
    end
  end

  match '/start', to: 'talks#start', via: 'get'
  match '/recent', to: 'talks#recent', via: 'get'
  match '/nearby', to: 'talks#nearby', via: 'get'
  match '/my_talks', to: 'talks#my_talks', via: 'get'

  resources :talks do
    collection do
      get :start, :search, :found
    end
  end

  resources :relationships, only: [:create, :destroy]

  # /my_talks -- using user2talk

  ## Account pages:
  # no edit, update, no index or show
  # create (login) uses 'post', destroy (logout) uses 'delete', new (show login form) uses 'get'
  resources :sessions, only: [:new, :create, :destroy]  

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

  ## have root go to splash if not signed in, home if signed in? or just leave home up on splash page?
  ## shift to 'start' when start is ready
  # root to: "static_pages#home"
  root to: "talks#start"

end
