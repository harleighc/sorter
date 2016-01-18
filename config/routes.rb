Rails.application.routes.draw do
  devise_for :users
  resources :categorytables


  match 'multipleitemupdate/new' => 'multipleitemupdate#new', :via => :get
  match 'multipleitemupdate/new' => 'multipleitemupdate#new', :via => :post

  match 'items/newcat' => 'items#newcat', :via => :get
  match 'items/newcat' => 'items#newcat', :via => :post


  root to: 'items#index'
 resources :items do

  
   match :update_category, via: [:get, :post], on: :collection #-> url.com/items/update_category
   collection {post :import}



   end

end
