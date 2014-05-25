class CreateWorkshopNotifications < ActiveRecord::Migration
  def up 
    create_table :workshop_notifications do |t|
      t.integer :workshop_id

      t.timestamp
    end
    WorkshopNotification.create_translation_table! :text => :text
  end

  def down
    drop_table :workshop_notifications
    WorkshopNotification.drop_translation_table!
  end
end
