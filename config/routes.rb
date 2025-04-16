#ルーティングとは「どのURLにアクセスすると、どのコントローラのどのアクションが実行されるか決めるもの」
Rails.application.routes.draw do
  get 'habit_posts/index'
  # 「devise_for」でログイン・登録に関するルートを1行で追加、その後ろで「Users::RegistrationsControllerを使用する」と宣言している
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  # プライバシーポリシー画面の作成
  get "privacy_policy", to: "static_pages#privacy_policy"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  #resourcesは「RESTful（アプリの決まりごと）なルーティングを簡単にまとめて設定できる便利な仕組み」
  #RESTfulは「Webアプリケーションの設計において、リソース（データ）を操作するための統一されたルールや考え方」
  #get 'item_posts', to: 'item_posts#index'　→ item_posts_path(resourcesと同じ)が生成
  #get 'item_posts/new', to: 'item_posts#new' → item_posts_new_path(resourcesと異なるpath)が生成
  #post 'item_posts', to: 'item_posts#create' → item_posts_pathが生成
  resources :item_posts, only: %i[new index create show edit update destroy] do
    collection do
      get :item_likes #collectionでRESTfulな設計を崩さず、item_postsに新しいアクション(item_likes)を加えることができ、item_posts全体に対するアクションとして意味付けできる
    end #また、直感的にURLがわかりやすくなる
    collection do
      get :ranking
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
    resources :habit_likes, only: %i[create destroy]
    resources :habit_comments, only: %i[create destroy], shallow: true
  end

  resource :profile, only: %i[show edit update]
  resources :diaries, only: %i[new create show edit update destroy]
  
  # Defines the root path route ("/")
  # root "posts#index"
end
