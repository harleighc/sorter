Rails.application.routes.draw do
  devise_for :users

 root to: 'items#index'
 resources :items do
   collection {post :import}

   end
  match 'items/multi' => 'items#multi', :via => :get
  match 'items/multi' => 'items#multi', :via => :post
  match 'items/newcat' => 'items#newcat', :via => :get
  match 'items/newcat' => 'items#newcat', :via => :post
end
