class CreateWorkshops < ActiveRecord::Migration
  def up
    create_table :workshops do |t|
      t.integer :city_id
      t.integer :group_id
      t.string :album
      t.datetime :release_date
      t.boolean :enabled
      t.boolean :requires_notification
      t.boolean :should_send_notification
      t.integer :master_id
      t.integer :location_id

      t.timestamps
    end
    Workshop.create_translation_table! :name => :string, :what => :text, :where => :text, :who => :text, :bring_along => :text
  end

  def down
    drop_table :workshops
    Workshop.drop_translation_table!
  end

end
