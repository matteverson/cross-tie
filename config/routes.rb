CrossTie::Application.routes.draw do
  
  get "static_pages/home"
  resources :rooms do
    collection {post :import}
  end

  devise_for :users
  
  resources :manifests do
    collection {post :download}
  end

  post 'manifests/match/:id', to: 'manifests#match', as: 'match_manifests'
  get 'bids/post_portal/:id', to: 'bids#post', as: 'post_to_portal'
  get 'manifests/import/:id', to: 'manifests#import', as: 'import_manifests'
  
  resources :items do
    collection {post :import}
  end

  resources :bids do
    collection {get :all}
  end

  root "static_pages#home"
  
  get 'properties/fetch', to: 'properties#fetch', as: "fetch_properties"
  
  resources :properties do 
    resources :bids
  end

  
end
