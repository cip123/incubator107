class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end

    add_index :participants, :email, unique: true
  end
end
