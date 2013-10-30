# routes.rb functions as a de facto map of the system
#
# main entry points are:
# 1. talks  -- especially searches
# 1. people -- especially signin/signup
# 1. venues -- less important than talks or people
# 
# could also build a 'sitemap', basically the pages that don't require you to specify a record,
#   -- possibly with signed in & not signed in versions
#   -- there is a great icon for this in the font-awesome set

# compare sitemap, home, start
#   -- start exists, home & sitemap don't (as yet)
#   -- could also build page all_searches, just for talks
#
# TBD:  static_pages/sitemap, talks/all_searches
# TBD:  make sure all routes named here are accessible via the normal flow

Talkinvite::Application.routes.draw do

  resources :calendars

  resources :maps

  resources :credits

  resources :faqs do
    member do
      get :help
    end
    collection do
      get :helps
    end
  end

  resources :ads

  resources :attachments

  resources :tags

  resources :messages

  resources :socials do
    member do
      get :map, :calendar
    end
  end

  resources :venues do 
    member do
      get :map, :calendar
    end
    collection do
      get :found, :search
    end
  end

  resources :notifications

  resources :comments

  resources :members do
    member do
      get :map, :calendar
    end
  end

  ## put most specific routes at the top:

  match '/settings', to: 'people#edit', via: 'get'
  match '/profile', to: 'people#show', via: 'get'
  match '/signup', to: 'people#new', via: 'get'
  match '/upgrade', to: 'people#upgrade', via: 'get'
  
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  # really want to route help with no id to helps, help with id to specific help,
  #   so /help -> /faqs/helps, /help/1 -> /faqs/1
  #   try this:
  match '/help/:id', to: 'faqs#help', via: 'get'
  match '/help', to: 'faqs#helps', via: 'get'

  ## Static pages:
  get "static_pages/about"
  get "static_pages/contact"
  get "static_pages/privacy"

  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/privacy', to: 'static_pages#privacy', via: 'get'

  # match '/teapot', to: 'static_pages#teapot', via: 'get'

  resources :people do
    ## member will give paths of the form:  /people/1/following, /people/1/followers
    ## actions are following, followers
    ## paths are following_people_path(id), followers_people_path(id)
    ##  i.e. people/1/following
    member do
      get :following, :followers, :oauth, :map, :calendar
    end
    collection do
      get :search, :found, :upgrade, :home
    end
  end

  match '/my_talks', to: 'talks#my_talks', via: 'get'
  match '/nearby', to: 'talks#nearby', via: 'get'
  match '/recent', to: 'talks#recent', via: 'get'
  match '/roulette', to: 'talks#roulette', via: 'get'
  match '/search', to: 'talks#search', via: 'get'
  match '/start', to: 'talks#start', via: 'get'

  resources :sessions, only: [:new, :create, :destroy]  

  resources :talks do
    ## collection will have lots of 'pick a talk' type pages
    member do
      get :map, :calendar, :control
    end
    collection do
      ## 'my_talks' uses current account to select set of talks, doesn't need to be member resource
      get :found, :my_talks, :nearby, :recent, :roulette, :search
    end
  end

  ## this map.connect thing might be useful, but apparently 'map' is just not found
  ## map.connect "talks/:action", :controller => 'talks', :action => /[a-z]+/i

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
