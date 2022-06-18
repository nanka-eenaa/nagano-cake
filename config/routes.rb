Rails.application.routes.draw do

  scope module: :public do
    root 'homes#top'
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    get 'customers/edit' => 'customers#edit', as: 'customer_edit'
    patch 'customers' => 'customers#update', as: 'customer_update'
    get 'customers/check' => 'customers#check', as: 'customer_check'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'customer_withdraw'
    resources :addresses, only:[:index, :create, :edit, :update, :destroy]
    resources :items, only:[:index, :show]
    resources :cart_items, only:[:create, :index, :update, :destroy]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'
    post 'orders/check' => 'orders#check', as: 'order_check'
    get 'orders/thanks' => 'orders#thanks', as: 'order_thanks'
    resources :orders, only:[:new, :create, :index, :show]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    resources :customers, only:[:index, :show, :edit, :update]
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :orders, only:[:index, :show, :update] do
      resources :order_details, only:[:update]
    end
  end

end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html