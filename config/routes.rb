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
    resources :genres, only: [:index, :create, :edit, :update]
  end


  scope module: :customers do
    resources :items, only: [:index, :show] do
      collection do
        get :sort
      end
    end
    resources :customers
    resources :addresses, except: [:new, :show]
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'thanks'
      end
    end
    get "/customers/:id" => "customers#show"
    get "/customers/:id/quit" => "customers#quit", as: 'customers_quit'
    put "/customers/:id/out" => "customers#out", as: 'customers_out'
    get "/customers/:id/edit" => "customers#edit"

    resources :cart_items, only: [:create, :index, :destroy, :update]
    delete 'cart_items' => 'cart_items#all_destroy', as: 'cart_all_destroy'

  end



end
