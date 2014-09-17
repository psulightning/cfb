class DropAuthTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :auth_token, :string
    remove_index :users, :auth_token if index_exists?(:users, :auth_token)
  end
end
