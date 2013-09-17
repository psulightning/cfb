class UserFacebookId < ActiveRecord::Migration
  def up
    add_column :users, :facebook_id, :bigint
  end
  
  def down
    remove_column :users, :facebook_id
  end
end
