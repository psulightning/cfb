class CreateRepetitions < ActiveRecord::Migration
  def change
    create_table :repetitions do |t|
      t.string :times
    end
  end
end
