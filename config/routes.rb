Rails.application.routes.draw do
  devise_for :users
  resources :items do
    resources :category
  end
  get 'category/new'
  post 'category/new'


 root to: 'items#index'
 resources :items do

   collection {post :import}




 end



end
