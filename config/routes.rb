Rails.application.routes.draw do
  get 'admin/index'

  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :members do
      member { get 'history' }
      collection { get 'search' }
  end

  resources :groups, :categories, :items
  # get 'members/search'
  # get 'members/:id/history', to: 'members#history'

  scope '/admin' do
    resources :groups, :members, :categories, :items, except: :show
    post 'members/borrow'
    post 'members/return'
  end

  # post '/loans/complete' => 'loans#complete'

  resources 'loans' do
    get 'index'
    post :complete
  end

  root 'welcome#index'
end
