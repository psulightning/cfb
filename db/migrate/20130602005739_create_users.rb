class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first
      t.string :last
      t.string :login
      t.datetime :last_login
      t.integer :permission

      t.timestamps
    end
  end
end
