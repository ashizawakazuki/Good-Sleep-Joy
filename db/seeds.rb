# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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
  
#     # 各ユーザーにランダムなアイテム投稿を3件作成
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
# item_tagsテーブルにあらかじめ選択肢を入れておく
ItemTag.create!(
  [
    {name: '寝具'},
    {name: '香りもの'},
    {name: 'リラックスグッズ'},
    {name: 'ガジェット'},
    {name: 'サプリメント'},
    {name: '照明'},
    {name: 'その他'},
  ]
)

# habit_tagsテーブルにあらかじめ選択肢を入れておく
HabitTag.create!(
  [
    {name: 'リラックス'},
    {name: '食事・飲み物'},
    {name: '軽めの運動'},
    {name: '心の整理'},
    {name: '呼吸・瞑想'},
    {name: 'その他'},
  ]
)