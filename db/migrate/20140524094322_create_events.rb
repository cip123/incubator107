class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_date
      t.integer :workshop_id
      t.integer :duration
      t.integer :location_id
      t.timestamps
    end
  end
end
