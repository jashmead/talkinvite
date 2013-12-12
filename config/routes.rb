# routes.rb functions as a de facto map of the system
#   -- put most specific routes at the top:
#   -- 10/31/13 -- checked that all routes have a controller 
#     -- & that all controller actions are internal or have a route
#   -- 11/18/13 -- reverted to completely unnested routes:
#     -- controller tests not working
#     -- form & form spec paths trickier
#   -- 12/26/13 -- added in devise
#
# main entry points are:
# 1. talk pages:  new, edit, my talks, search 
# 1. account pages:  show, edit, home
# 1. session pages:  sign_in, sign_out
# 1. maps:  add map, change, save
# 1. member pages:  join (& regrets)
# 1. posts: announce (also change, cancel, mark done)
# 1. services: setup services for use in posts
# 1. messages:  talk to other talkers
# 1. static pages:  about, contact, privacy
# 1. credits
# 1. helps
# 
Talkinvite::Application.routes.draw do

  # devise_for added by devise install process
  devise_for :people

  devise_scope :person do
    get 'sign_up', :to => 'devise/registrations#new'
    get 'sign_in', :to => 'devise/sessions#new'
    delete 'sign_out', :to => 'devise/sessions#destroy'
    get 'reset_password', :to => 'devise/passwords#new'
    # get 'change_password', :to => 'devise/passwords#edit' # change_passwords is an interior form, not useful without a token
    get 'settings', :to => 'devise/registrations#edit'
  end

  match '/my_messages', to: 'messages#my_messages', via: 'get'
  resources :messages do
    collection do
      get :my_messages
    end
  end

  resources :posts, :members, :maps, :calendars

  # talks:

  resources :talks do

    member do
      get :control, :map
    end

    # these are for talks in general
    collection do
      get :found, :search, :start
    end

  end

  # Since 'talks' are the central concept, allow for direct routes to them
  # START of alternative routes into talks
  match '/talks/index', to: 'talks#index', via: 'get'
  match '/talks', to: 'talks#index', via: 'get'

  # search is just index + a search field
  match '/talks/search', to: 'talks#search', via: 'get'
  match '/search', to: 'talks#search', via: 'get'

  # talkinvite starts with talks
  match '/talks/start', to: 'talks#start', via: 'get'
  match '/start', to: 'talks#start', via: 'get'

  # since we always have a default person (even if only anonymous) can fold in a 'new'
  # TBD:  we will need to trap the save & make sure we have a non-anonymous person on our hands before save!
  match '/talks/new', :controller => 'talks', :action => 'new', via: 'get'
  # END of alternative routes into talks

  # this map.connect thing might be useful, but apparently 'map' is just not found
  # map.connect "talks/:action", :controller => 'talks', :action => /[a-z]+/i

  # Account & related pages:

  # services nested under people, may wish to shift to nested architecture for that
  # TBD:  see if we wish to nest services inside people
  
  resources :services

  # note: have removed the sessions controller, not needed when using devise, it seems
  # resources :sessions, only: [:new, :create, :destroy, :reset_password]  

  # people pages: 
  
  # note:  a number of the routes one normally associates with people are run by devise instead, see above
  match '/home', to: 'people#home', via: 'get'
  resources :people do
    collection do
      get :home, :found, :search, :start
    end
  end

  # helps & credits

  get '/helps/new', to: 'helps#new' # otherwise new is treated as the name of a help text

  # TBD:  add a /help/page/action route?
  # note:  get is a function within the routing, to & constraints are named options to 'get'
  get '/help/:name', to: 'helps#help', constraints: { name: /[A-Za-z][A-Za-z0-9_]*/ }
  get '/helps/:name', to: 'helps#help', constraints: { name: /[A-Za-z][A-Za-z0-9_]*/ }

  resources :helps, :credits

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

  # root to: "static_pages#sitemap"
  root to: "talks#start"

end
