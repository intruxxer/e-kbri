EKbri::Application.routes.draw do

  resources :visas, controller: 'immigration/visa'
  resources :visafamilys, controller: 'immigration/visafamily'
  resources :visagroups, controller: 'immigration/visagroup'
  resources :passports, controller: 'immigration/passport'
  resources :reports, controller: 'immigration/report'  
  resources :cases
    
  get "dashboard/protocols", :to => "protocol#index"
  
  authenticated :user do
    root to: 'welcome#index', as: :authenticated_root
  end

  unauthenticated do
    root to: "welcome#index"
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations", 
    passwords: "users/passwords", 
    confirmations: "users/confirmations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  
  devise_scope :user do 
    get "/users/sign_out" => "devise/sessions#destroy" 
  end 
  
  resources :users
  get "searchuser", :to => "users#search"
  
  get "infovisas", :to => "immigration/visa#info"   
  get "infopassports", :to => "immigration/passport#info"
  get "inforeports", :to => "immigration/report#info"
  get "bantuan", :to => "cases#info"
  get "lapormasalah", :to => "cases#index"
  get "marriage/info", :to => "immigration/marriage#info"
  
  get "overview", :to => "immigration/flow#systemoverview"
  get "payment", :to => "immigration/flow#systempayment"
  get "visaflow", :to => "immigration/flow#visa"   
  get "visadocs", :to => "immigration/flow#visadocs"
  get "passportflow", :to => "immigration/flow#passport"
  get "passportdocs", :to => "immigration/flow#passportdocs"
  get "reportflow", :to => "immigration/flow#report"
  get "reportdocs", :to => "immigration/flow#reportdocs"

  get "finishgroupapply", :to => "immigration/visa#finishing_application"
  get "visas/reapply/:id", :to => "immigration/visa#reapply"
  get "passports/reapply/:id", :to => "immigration/passport#reapply"
  
  get "dashboard/index"
  get "dashboard/masalahwni", :to => "cases#masalahwni"
  get "dashboard/formulirmasalahwni", :to => "cases#formulirmasalahwni", as: "formulirmasalahwni"
  match "dashboard/deletemasalahwni/:id", to: "cases#destroy", as: "deletemasalahwni", via: :get

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
  
  match "statistics", :to => "statistics#index", via: :get
  
  get "visa/show/all", :to => "desktop#show_all_sisari"
  get "lapordiri/show/all", :to => "desktop#show_all_lapordiri"
  get "lapordiri/show/history/:user_id", :to => "desktop#show_all_lapordiri_history"
  get "passport/show/all", :to => "desktop#show_all_spri"
  get "case/list/all", :to => "desktop#show_all_cases"
  get "dashboard/service/:document", :to => "dashboard#immigration"
  get "admin/service/:document/:id", :to => "dashboard#immigration"
  get "dashboard/syncpanel", :to => "dashboard#syncpanel"
  get "journal/list/all", :to => "journal#show_all_journal"

  
  
  match "passport/tospri/:id", to: "desktop#exec_toSPRI", via: :post
  match "visa/tosisari/:id", to: "desktop#exec_toSisari", via: :post
  
  get "passports/:id/check", :to => "immigration/passport#check"
  get "visas/:id/check", :to => "immigration/visa#check"
  get "reports/:id/check", :to => "immigration/report#check"
  get "reports/:whosign/:id", :to => "immigration/report#show"
  get "reports/user/print/:id", :to => "immigration/report#show"
  
  get "protocol/synccloudtolocal/:collection", :to => "protocol#syncCollectionCloudtoLocal"
  get "protocol/syncdbcomplete", :to => "protocol#syncDBComplete"
  

  match "report/findbynameandbirth", to: "immigration/report#findbyNameandBirth", via: :get
  
  get "report/panel/periodical", :to => "dashboard#periodical_reporting"
  get "report/panel/periodical_printed_based", :to => "dashboard#periodical_reporting_printed_based"
  match "report/generate/periodical", to: "dashboard#generate_periodical_reporting", via: :post  
  match "report/generate/periodical_printed_based", to: "dashboard#generate_periodical_reporting_printed_based", via: :post
  
  get "export/table/:doc", :to => "desktop#export_table"
  
  get '/images/:name', :to => 'images#show', :as => :custom_image
  
  get "finishgroupapply", :to => "immigration/visa#finishing_application"
  get "deletepassportviadashboard/:id", :to => "desktop#destroy_passport", via: :delete, :as => :deletepassportviadashboard
  get "deletevisaviadashboard/:id", :to => "desktop#destroy_visa", via: :delete, :as => :deletevisaviadashboard
  get "deleteuserviadashboard/:id", :to => "desktop#destroy_user", via: :delete, :as => :deleteuserviadashboard
  
  get "visas/reapply/:id", :to => "immigration/visa#reapply"
  get "passports/reapply/:id", :to => "immigration/passport#reapply"
  
  get "dashboard/reference/list", :to => "reference#index"
  get "dashboard/reference/edit/:type/:id", :to => "reference#edit"
  match "/dashboard/reference/update_visafee", :to => "reference#update_visafee", via: :put, :as => :update_visafee_list
  match "/dashboard/reference/update_passportfee", :to => "reference#update_passportfee", via: :put, :as => :update_passportfee_list
  match "/dashboard/reference/update_signature", :to => "reference#update_reference", via: :put, :as => :update_reference_list
  
  get "passport/payment/:id", :to => "immigration/passport#payment"
  match "passport/payment/:id", to: "immigration/passport#update_payment", via: :patch, :as => :payment_proceed
  
  get "visas/compile/:ref_id", :to => "immigration/visa#show_receipt", :as => :visa_compile
  get "visas/payment/:ref_id", :to => "immigration/visa#payment"
  match "visas/payment/:ref_id", to: "immigration/visa#update_payment", via: :patch, :as => :visa_payment_proceed

  match "report/admin/:id/edit", to: "immigration/report#adminupdate", via: :patch, :as => :adminreportedit
  get "journal/show/:id", :to => "journal#retrieve_document_journal", :as => :document_journal
  get "samplepayment", :to =>"welcome#showsamplebayar"
  
  get "visas/group/:ref_id", to: "immigration/visa#group_recap"
  
  get "delete/user/passport/:id", :to => "immigration/passport#destroy", :as => :userdeletepassport
  get "delete/user/visa/:id", :to => "immigration/visa#destroy", :as => :userdeletevisa
  
  #resources :dashboard_immigration, path: "dashboard/immigration"
  #Experimental Controller#
  get "playground", :to => "playground#index"
  match "experiment", :to => "playground#experiment", via: :all
  #match '*path', via: :all, to: 'pages#error_404'
  

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
