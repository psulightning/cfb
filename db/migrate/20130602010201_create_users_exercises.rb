class CreateUsersExercises < ActiveRecord::Migration
  def change
    create_table :users_exercises do |t|
      t.integer :user_id
      t.integer :exercise_id
    end
  end
end
