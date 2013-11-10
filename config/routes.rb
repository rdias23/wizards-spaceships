WizardsAndSpaceships::Application.routes.draw do
  get "home/index"
  devise_for :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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

  root :to => "home#landing"
  resources :book
  get 'update_side_menu' => 'home#update_side_menu'
  post 'update_side_menu' => 'home#update_side_menu'
  get 'update_gallery' => 'home#update_gallery'
  post 'update_gallery' => 'home#update_gallery'
  get 'page' => 'book#page'
  post 'new_topic' => 'book#new_topic'
  post 'new_comment' => 'book#new_comment'
  patch 'rate_book' => 'book#rate_book'
  get 'page_topic' => 'book#page_topic'
  post 'page_topic' => 'book#page_topic'
  post 'update' => 'book#update'
  patch 'update' => 'book#update'
  get 'vote_topic' => 'book#vote_topic'
  post 'new_comment2' => 'book#new_comment2'
  post 'new_comment3' => 'book#new_comment3'
  get 'add_comment_reply' => 'book#add_comment_reply'
  get 'add_comment2_reply' => 'book#add_comment2_reply'

end
