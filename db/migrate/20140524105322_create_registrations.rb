class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :event_id
      t.integer :person_id
      t.boolean :notification_sent
      t.text :reason

      t.timestamps
    end
  end
end
