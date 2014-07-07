class CreateWorkshopParticipants < ActiveRecord::Migration
  def change
    create_table :workshop_participants do |t|
      t.integer :workshop_id
      t.integer :participant_id
      t.string :reason
      t.boolean :display

      t.timestamps
    end
  end
end
