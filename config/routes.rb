Rails.application.routes.draw do
  get 'admin/index'

  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '/admin' do
    resources :groups, :members, :categories, :items
    get 'members/search'
    post 'members/borrow'
    post 'members/return'
  end

  # post '/loans/complete' => 'loans#complete'

  resources 'loans' do
    post :complete
  end

  root 'welcome#index'
end
