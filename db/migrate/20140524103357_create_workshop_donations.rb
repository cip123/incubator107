class CreateWorkshopDonations < ActiveRecord::Migration
  def up 
    create_table :workshop_donations do |t|
      t.integer :workshop_id
      t.timestamps
    end

    WorkshopDonation.create_translation_table! :text => :text
  end

  def down
    drop_table :workshop_donations
    WorkshopDonation.drop_translation_table! 
  end
end
