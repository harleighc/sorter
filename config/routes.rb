Rails.application.routes.draw do
  devise_for :users
  resources :categorytables
  
  resources :csv


  match 'items/csv' => 'items#csv', :via => [:get, :post]
  match 'items/login' => 'items#login', :via => [:get, :post]
  match 'items/test' => 'items#test', :via => [:get, :post]

  get 'edit_category' => 'items#edit_category'

 root to: 'items#index'
 resources :items do


  match :update_category, via: [:get, :post], on: :collection  #-> url.com/items/update_category


collection {post :import}



   end

end

# get 'edit_category' => 'items#edit_category'
# get 'categorytables/edit_name' => 'categorytables#edit'
