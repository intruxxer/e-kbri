EKbri::Application.routes.draw do
  resources :visas, controller: 'immigration/visa'
  resources :visafamilys, controller: 'immigration/visafamily'
  resources :visagroups, controller: 'immigration/visagroup'
  resources :passports, controller: 'immigration/passport'
  resources :reports, controller: 'immigration/report'
  
  get "dashboard/protocols", :to => "protocol#index"
  
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
  
  get "infovisas", :to => "immigration/visa#info"   
  get "infopassports", :to => "immigration/passport#info"
  get "inforeports", :to => "immigration/report#info"
  get "marriage/info", :to => "immigration/marriage#info"
  get "finishgroupapply", :to => "immigration/visa#finishing_application"
  get "visas/reapply/:id", :to => "immigration/visa#reapply"
  get "passports/reapply/:id", :to => "immigration/passport#reapply"
  
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
  
  #Unit Test Framework#
  get "playground", :to => "playground#index"
  get "test", :to => "playground#test"
  
  get "visa/show/all", :to => "desktop#show_all_sisari"
  get "visa/tosisari/:id", :to => "desktop#exec_toSisari"
  get "passport/show/all", :to => "desktop#show_all_spri"
  get "dashboard/service/:document", :to => "dashboard#immigration"
  get "admin/service/:document/:id", :to => "dashboard#immigration"
  get "dashboard/syncpanel", :to => "dashboard#syncpanel"
  
  match "passport/tospri/:id", to: "immigration/dekstop#exec_toSPRI", via: :post
  
  get "protocol/synccloudtolocal/:collection", :to => "protocol#syncCollectionCloudtoLocal"
  get "protocol/syncdbcomplete", :to => "protocol#syncDBComplete"
  
  
  
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
