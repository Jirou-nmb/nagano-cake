Rails.application.routes.draw do

  root "customers/homes#top"
  get "/about" => "customers/homes#about"

  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do # => /admin/items etc
    resources :items
    resources :customers, only: [:index, :show, :edit, :update]
  end

  scope module: :customers do # => /items
    resources :items
  end

end
