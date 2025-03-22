Kaminari.configure do |config|
  config.default_per_page = 20 # 1ページあたりに表示される件数を設定
  # config.max_per_page = nil
  config.window = 2 # 現在いるページから前後何ページを表示するか設定
  config.outer_window = 1 # 先頭と末尾に何ページ分表示するか設定
  # config.left = 0
  # config.right = 0
  # config.page_method_name = :page
  # config.param_name = :page
  # config.max_pages = nil
  # config.params_on_first_page = false
end
