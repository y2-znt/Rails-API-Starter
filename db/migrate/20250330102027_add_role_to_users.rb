class AddRoleToUsers < ActiveRecord::Migration[8.0]
  def change
    create_enum :user_role, %w[admin user]
    add_column :users, :role, :user_role, default: "user", null: false
  end
end
