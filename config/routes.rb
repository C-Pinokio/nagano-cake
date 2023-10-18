Rails.application.routes.draw do
 # 管理者用
  devise_for :admin, skip: [:registrations, :password], controllers: {
  sessions: "admin/sessions"
  }
# 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

# 管理者側のルーティング
  namespace :admin do
    root to: 'home#top'
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update] 
    resources :order_details, only: [:update]
    end

# 顧客側のルーティング
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    get 'customers/mypage' => 'customers#show'
    get 'customers/infomation/edit' => 'customers#edit'
    patch 'customers/infomation' => 'customers#update'
    get 'customers/confirm' => 'customers#confirm'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      #collection doは７つのアクション以外の独自のアクションをリソースに追加するものです
      collection do
        delete 'destroy_all'
      end
    end
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'complete'
      end
    end
    resources :addresses, except: [:new, :show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
