class CreateMonthAthletes < ActiveRecord::Migration

  def change
    create_table :month_athletes do |t|
      t.string :name
      t.integer :month
      t.integer :year
      t.integer :picture_id
      t.text :description
      t.timestamps
    end
  end

end