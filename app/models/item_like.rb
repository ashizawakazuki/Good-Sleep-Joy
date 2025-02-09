class ItemLike < ApplicationRecord
  belongs_to :user
  belongs_to :item_post

  # 「user_id と item_post_id の組み合わせがデータベース内で一意（ユニーク）であることを保証する」という制約
  # 1人のユーザーが1つの投稿に対して、1回しか「いいね」できないようにするためのもの
  # scope は、「どのカラムを基準に uniqueness を判定するか」を指定するオプション
  # scopeで、「同じ item_post_id の中で user_id が重複しないようにする」 というルールを作っている
  validates :user_id, uniqueness: { scope: :item_post_id }
end
