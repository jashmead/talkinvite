## TBD:
##  get splash, about, contact up

# routes.rb functions as a de facto map of the system

# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

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
  #   in tutorial we have: resources :talks, only: [:create, :destroy], may wind up doing that for posts, we'll see

  resources :talks
  # /my_talks -- using user2talk

  ## add in users/name with instructions to locate id & then route to it
  ## do subscribe via a link from the header (as indicated); do unsubscribe from settings page
  resources :people

  ## Account pages:
  # no edit, update, no index or show
  # create (login) uses 'post', destroy (logout) uses 'delete', new (show login form) uses 'get'
  resources :sessions, only: [:new, :create, :destroy]  

  match [ '/settings', '/profile' ], to: 'people#edit', via: 'get'
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
  get "static_pages/splash"

  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/credits', to: 'static_pages#credits', via: 'get'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/menu', to: 'static_pages#menu', via: 'get'
  match '/privacy', to: 'static_pages#privacy', via: 'get'
  match '/splash', to: 'static_pages#splash', via: 'get'

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

  root to: "static_pages#splash"

end
