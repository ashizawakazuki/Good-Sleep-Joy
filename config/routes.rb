#ルーティングとは「どのURLにアクセスすると、どのコントローラのどのアクションが実行されるか決めるもの」
Rails.application.routes.draw do
  get 'habit_posts/index'
  # 新規登録失敗時、フラッシュメッセージを表示させるために「controllers: { registrations: 'registrations' }」を追加
  devise_for :users, controllers: { registrations: 'registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  #resourcesは「RESTfulなルーティングを簡単にまとめて設定できる便利な仕組み」
  #RESTfulは「Webアプリケーションの設計において、リソース（データ）を操作するための統一されたルールや考え方」
  #get 'item_posts', to: 'item_posts#index'　→ item_posts_path(resourcesと同じ)が生成
  #get 'item_posts/new', to: 'item_posts#new' → item_posts_new_path(resourcesと異なるpath)が生成
  #post 'item_posts', to: 'item_posts#create' → item_posts_pathが生成
  resources :item_posts, only: %i[new index create show edit update destroy]
  resources :habit_posts, only: %i[index new create show edit update destroy]
  resource :profile, only: %i[show edit update]
  # Defines the root path route ("/")
  # root "posts#index"
end
