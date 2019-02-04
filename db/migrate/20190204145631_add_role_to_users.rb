class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :role, :string, null: false, default: "reader"

    User.where(role: nil).update(role: "reader")
  end

  def down
    remove_column :users, :role
  end
end
