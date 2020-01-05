class AddLikesCountToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :likes_count, :bigint, default: 0, null: false
  end
end
