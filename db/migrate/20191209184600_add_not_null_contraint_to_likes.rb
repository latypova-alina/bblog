class AddNotNullContraintToLikes < ActiveRecord::Migration[5.1]
  def change
    change_column_null(:likes, :user_id, false)
    change_column_null(:likes, :post_id, false)
  end
end
