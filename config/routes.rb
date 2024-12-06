#ルーティングとは「どのURLにアクセスすると、どのコントローラのどのアクションが実行されるか決めるもの」
Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'item_posts', to: 'item_posts#index' #あとでresoucesを使って書き直す
  get 'item_posts/new', to: 'item_posts#new'
  # Defines the root path route ("/")
  # root "posts#index"
end
