Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'admin/index'

  post 'versions/:id/revert' => 'versions#revert', :as=>'revert_version'
  # resources :groups, :categories, :items
  # get 'members/search'
  # get 'members/:id/history', to: 'members#history'

  # scope '/admin' do
  resources :groups, :categories, :loans
  resources :members do
    member { post 'borrow' }
    member { post 'return' }
    member { get 'history' }
    member { get 'items' }
    collection { get 'search' }
  end


  resources :items do
    collection { get 'search' }
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resource :members, only: [:index, :show] do
  #     member { get 'history' }
  #     collection { get 'search' }
  # end

  get 'welcome/index'
  root 'welcome#index'
  # get :search, controller: :member
end
