EKbri::Application.routes.draw do
  resources :batch 
  resources :visas, controller: 'immigration/visa'
  resources :passports, controller: 'immigration/passport'
  resources :reports, controller: 'immigration/report'
  
  authenticated :user do
    root to: 'welcome#index', as: :authenticated_root
  end

  unauthenticated do
    root to: "welcome#index"
  end

  devise_for :users, controllers: {
    registrations: "users/registrations", 
    passwords: "users/passwords", 
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  
  devise_scope :user do 
    get "/users/sign_out" => "devise/sessions#destroy" 
  end 
  
  resources :users
  
  get "marriage/info", :to => "immigration/marriage#info"   
  
  get "dashboard/index"
  get "dashboard/counsel"
  get "dashboard/immigration"
  get "dashboard/immigration/:document" => "dashboard#immigration" 
  get "dashboard/employment_indonesia"
  get "dashboard/employment_korea"
  get "dashboard/tabulation"
  get "dashboard/statistics"
  get "dashboard", :to => "dashboard#index"
  
  get "welcome/concept"
  get "concept/index"
  get "concept", :to => "concept#index"
  
  #resources :dashboard_immigration, path: "dashboard/immigration"
  

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
end
