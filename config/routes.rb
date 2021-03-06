Public::Application.routes.draw do

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :invitations => 'users/invitations'
  }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  unauthenticated do
    root 'welcome#index'
  end

  authenticated :user do
    root 'discussions#index', as: 'authenticated_root'
  end

  get "about" => 'welcome#about'
  get "team" => 'welcome#team'
  get "contact" => 'welcome#contact'
  post "contact" => 'welcome#message'
  get "blog" => 'welcome#blog'
  get "features" => 'welcome#features'
  get "pricing" => 'welcome#pricing'
  get "terms" => 'welcome#terms'
  get "privacy" => 'welcome#privacy'
  post "newsletter" => 'welcome#newsletter'

  get 'settings' => 'settings#show'
  put 'settings' => 'settings#update'

  get 'p/n/:token' => 'public#show', as: 'public_note'

  resource :incoming, :controller => 'incoming', :only => [:show,:create]

  resources :discussions do
    resources :notes
  end

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
