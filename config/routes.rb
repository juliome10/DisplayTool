TFG::Application.routes.draw do

  resources :dispositivofisicos

  resources :parametros

  resources :estilos

  resources :listareproducions

  resources :dispositivoloxicos

  resources :subformatos

  resources :diapositivas

  resources :campos

  resources :formatos

  resources :diapositivas_listareproducions

  resources :uploads
  
  #Enrutado para diapositivas estáticas.
  match "/diapositivas_listareproducions/public/contidos/:diapositiva" => redirect("/contidos/%{diapositiva}")
  match "/listareproducions/public/contidos/:diapositiva" => redirect("/contidos/%{diapositiva}")
  match "/listareproducions/:id/public/contidos/:diapositiva" => redirect("/contidos/%{diapositiva}")
  match "/diapositivas/public/contidos/:diapositiva" => redirect("/contidos/%{diapositiva}")
  match "/diapositivas/:id/public/contidos/:diapositiva" => redirect("/contidos/%{diapositiva}")
  match "/public/contidos/:diapositiva" => redirect("/contidos/%{diapositiva}")

  #Enrutado de diapositivas para proba
  match "public/contidos/:diapositiva" => redirect("/contidos/%{diapositiva}")

  #Enrutado para as listas de reprodución con diapositivas estáticas.
  match "/listareproducions/public/listas/:lista/:diapositiva" => redirect("/listas/%{lista}/%{diapositiva}")
  match "/listareproducions/:id/public/listas/:lista/:diapositiva" => redirect("/listas/%{lista}/%{diapositiva}")
  match "/public/listas/:lista/:diapositiva" => redirect("/listas/%{lista}/%{diapositiva}")

  #Enrutado para as páxinas de inicio dos dispositivos físicos
  match "dispositivofisicos/public/dispositivos/:dispositivo/inicio.html" => redirect("/dispositivos/%{dispositivo}/inicio.html")
  match "/dispositivos/:dispositivo/public/listas/:lista/:diapositiva" => redirect("/listas/%{lista}/%{diapositiva}")
  
  #Enrutado para a nova acción das listas de reprodución
  post 'listareproducions/:id/edit', :controller => 'listareproducions', :action => 'edit', :id => '%{id}'
  post 'diapositivas/uploadFile'
  post 'uploads/uploadFile'

  #Enrutado para a acción de desvincular un campo dun formato
  post 'campos/desvincular'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
