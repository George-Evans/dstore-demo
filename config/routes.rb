Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}

  resources :users

  resources :products do
    resources :comments
  end


  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/index'
  root 'static_pages#landing_page'

	post 'static_pages/thank_you'

  post 'products/payments/create', to: 'payments#create'
  get 'payments/create'

  resources :orders, only: [:index, :show, :create, :destroy]

  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
