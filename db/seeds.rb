# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#開発環境のみ実行する
if Rails.env.development?
  # 既存のデータを削除
  ItemPost.delete_all
  User.delete_all
  ItemTag.delete_all
  # ユーザーを10人作成
  10.times do
    user = User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: "password",  # 同じパスワードを使用
      password_confirmation: "password"
    )
  
    # 各ユーザーにランダムなアイテム投稿を3件作成
    20.times do
      user.item_posts.create!(
        title: Faker::Lorem.sentence(word_count: 3),
        body: Faker::Lorem.paragraph(sentence_count: 5)
      )
    end

    # 各ユーザーにランダムな習慣投稿を3件作成
    20.times do
      user.habit_posts.create!(
        title: Faker::Lorem.sentence(word_count: 3),
        body: Faker::Lorem.paragraph(sentence_count: 5)
      )
    end
  end
end

# 本番環境・開発環境問わず：タグの初期データを入れる
# item_tagsテーブルにあらかじめ選択肢を入れておく
item_tags = [
  {name: '寝具'},
  {name: '香りもの'},
  {name: 'リラックスグッズ'},
  {name: 'ガジェット'},
  {name: 'サプリメント'},
  {name: '照明'},
  {name: 'その他'},
]

item_tags.each do |tag|
  ItemTag.find_or_create_by!(name: tag[:name])
end

# habit_tagsテーブルにあらかじめ選択肢を入れておく
habit_tags = [
  {name: 'リラックス'},
  {name: '食事・飲み物'},
  {name: '軽めの運動'},
  {name: '心の整理'},
  {name: '呼吸・瞑想'},
  {name: 'その他'},
]

habit_tags.each do |tag|
  HabitTag.find_or_create_by!(name: tag[:name])
end