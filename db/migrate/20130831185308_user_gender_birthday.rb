class UserGenderBirthday < ActiveRecord::Migration
  def self.up
    add_column :users, :gender, :string, :limit=>1
    add_column :users, :birthday, :date
  end
  def self.down
    remove_column :users, :birthday
    remove_column :users, :gender
  end
end
