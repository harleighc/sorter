Rails.application.routes.draw do
  devise_for :users
  resources :categorytables

  resources :csv


  match 'items/csv' => 'items#csv', :via => [:get, :post]
  match 'items/login' => 'items#login', :via => [:get, :post]
  match 'items/test' => 'items#test', :via => [:get, :post]
  match 'items/expand' => 'items#expand', :via => [:get, :post]

  get 'edit_category' => 'items#edit_category'
  get 'edit_checks_mult' => 'items#edit_checks_mult'
  get 'edit_checks_ind' => 'items#edit_checks_ind'

  get 'edit_confirms' => 'items#edit_confirms'
  get 'edit_gst' => 'items#edit_gst'


 root to: 'items#index'
 resources :items do

match :update_gst, via: [:get, :post], on: :collection
  match :update_category, via: [:get, :post], on: :collection
   match :update_checks_mult, via: [:get, :post], on: :collection
   match :update_checks_ind, via: [:get, :post], on: :collection
  match :update_confirms, via: [:get, :post], on: :collection
   match :update_checks, via: [:get, :post], on: :collection

collection {post :import}



   end

end

# get 'edit_category' => 'items#edit_category'
# get 'categorytables/edit_name' => 'categorytables#edit'
