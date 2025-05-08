Rails.application.routes.draw do
  get 'habit_posts/index'
  # 「devise_for」でログイン・登録に関するルートを1行で追加
  # 「registrations: 'users/registrations'」で新規登録をカスタマイズ
  # 「passwards: 'users/passwords'」でパスワードリセット機能を実装
  # 「omniauth_callbacks: "users/omniauth_callbacks"」でGoogleログイン機能を実装
  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'static_pages#top'
  # プライバシーポリシー
  get "privacy_policy", to: "static_pages#privacy_policy"
  #利用規約
  get "terms", to: "static_pages#terms"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :item_posts, only: %i[new index create show edit update destroy] do
    collection do
      get :item_likes #collectionでitem_postsに新しいアクション(item_likes)を加えることができる
    end
    collection do
      get :ranking
    end
    collection do
      get :search
    end
    resources :item_likes, only: %i[create destroy] 
    resources :item_comments, only: %i[create destroy], shallow: true
  end

  resources :habit_posts, only: %i[index new create show edit update destroy] do
    collection do
      get :habit_likes
    end
    collection do
      get :ranking
    end
    collection do
      get :search
    end
    resources :habit_likes, only: %i[create destroy]
    resources :habit_comments, only: %i[create destroy], shallow: true
  end

  resource :profile, only: %i[show edit update]
  resources :diaries, only: %i[new create show edit update destroy]
  
end
