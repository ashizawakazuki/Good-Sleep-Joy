class CreateHabitPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :habit_posts do |t|
      t.string :title, null: false #string型（255文字まで）、null(必ずデータが入る)に設定
      t.text  :body, null: false #body型（65535文字まで）、null(必ずデータが入る)に設定
      t.references :user, foreign_key: true #referencesで外部キーを設定、「foreign_key: true」で必ずuserテーブルのIDに存在する値でないといけないと言うルールを設定

      t.timestamps
    end
  end
end
