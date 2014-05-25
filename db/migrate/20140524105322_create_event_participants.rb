class CreateEventParticipants < ActiveRecord::Migration
  def change
    create_table :event_participants do |t|
      t.integer :event_id
      t.integer :participant_id
      t.boolean :notification_sent

      t.timestamps
    end
  end
end
