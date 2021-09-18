Rails.application.routes.draw do
  root  'inquiry#index'
  get   'inquiry'         => 'inquiry#index'
  post  'inquiry/confirm' => 'inquiry#confirm'
  post  'inquiry/thanks'  => 'inquiry#thanks'
  # 確認する

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'

  resources :posts, only: [:new, :index, :show, :create, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'

  end
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:show,:create]

  get '/searches' => 'searches#search'
  # タグ検索
  get 'tags/:tag', to: 'posts#index', as: :tag

  resources :notifications, only: :index

end
