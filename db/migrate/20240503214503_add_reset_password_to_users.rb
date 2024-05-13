class AddResetPasswordToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :reset_password_token, :string unless column_exists?(:users, :reset_password_token)
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
  end
end
