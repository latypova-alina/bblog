class AddForeignKeysConstraintToLikes < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :likes, :users
    add_foreign_key :likes, :posts
  end
end
