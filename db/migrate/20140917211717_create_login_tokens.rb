class CreateLoginTokens < ActiveRecord::Migration
  def change
    create_table :login_tokens do |t|
      t.integer :user_id, :null=>false
      t.string :token
      t.boolean :permanent
      t.timestamps
      t.datetime :last_accessed
      
      t.index :user_id
      t.index :token
      t.index :permanent
      t.index :last_accessed
    end
  end
end
