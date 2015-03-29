class CreateEvents < ActiveRecord::Migration

  def change
    create_table :events do |t|
      t.string :title
      t.date :event_date
      t.text :description
      t.string :location
      t.timestamps
      
      t.index :event_date
      
    end
    execute 'CREATE FULLTEXT INDEX fulltext_index_events_description ON events (description)'
  end

end