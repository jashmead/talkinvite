## TBD:
##  get splash, about, contact up

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
  resources :talks
  resources :relationships, only: [:create, :destroy]

  # /my_talks -- using user2talk

  ## add in users/name with instructions to locate id & then route to it
  ## do subscribe via a link from the header (as indicated); do unsubscribe from settings page
  resources :people do
    ## member will give paths of the form:  /people/1/following, /people/1/followers
    ## actions are following, followers
    ## paths are following_people_path(id), followers_people_path(id)
    member do
      get :following, :followers
    end
    ## collection in place of member would give paths of the form:  /people/following, /people/followers, which in context are meaningless
  end

  ## Account pages:
  # no edit, update, no index or show
  # create (login) uses 'post', destroy (logout) uses 'delete', new (show login form) uses 'get'
  resources :sessions, only: [:new, :create, :destroy]  

  match [ '/settings', '/profile' ], to: 'people#edit', via: 'get'
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
  get "static_pages/splash"

  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/credits', to: 'static_pages#credits', via: 'get'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/menu', to: 'static_pages#menu', via: 'get'
  match '/privacy', to: 'static_pages#privacy', via: 'get'
  match '/splash', to: 'static_pages#splash', via: 'get'
  match '/gottalk', to: 'static_pages#splash', via: 'get'

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
  ## shift to 'splash' when splash is ready
=begin
  If deleting talks from the home page, we seem to get routed via the splash page controller
  -- to avoid this have to set the root page to be people#home, rather than preferred static_pages/splash
    -- or, in future, talks/splash!
  -- looks like implicit tieing of talk delete function to root_path
    -- where is this happening, if it is?
  error message on form:
          
  <%= form_for(@talk) do |f| %>
    <%= render 'shared/error_messages', :object => f.object %>
    <div class="field">
      <%= f.text_field :summary, placeholder: "About..." %>

Trace of template inclusion: app/views/static_pages/splash.html.erb

  error is first argument to form_for can't be null
    -- this is @talk
    -- set in people controller, not in splash controller
      -- ok, but why are we in the splash controller?
      -- how did calling home get us to splash?
=end
  ## root to: "static_pages#splash"
  root to: "people#home"

end
