## TBD:
##  added in login, logout, settings for people

# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

Talkinvite::Application.routes.draw do
  resources :calendars

  resources :maps

  resources :attachments

  resources :tweets

  resources :tags

  resources :posts

  resources :talks

  resources :locations

  resources :people

  match '/signup', to: 'people#new', via: 'get'

  get "static_pages/about"
  get "static_pages/contact"
  get "static_pages/credits"
  get "static_pages/help"
  get "static_pages/menu"
  get "static_pages/privacy"
  get "static_pages/splash"

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
