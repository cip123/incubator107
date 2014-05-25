class CreateWorkshopParticipants < ActiveRecord::Migration
  def change
    create_table :workshop_participants do |t|
      t.string :workshop_id
      t.string :participant_id
      t.string :reason
      t.boolean :display

      t.timestamps
    end
  end
end
