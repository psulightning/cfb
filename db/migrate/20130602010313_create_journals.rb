class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.integer :users_exercises_id
      t.integer :repetition_id
      t.string :weight_time
      t.string :notes

      t.timestamps
    end
  end
end
