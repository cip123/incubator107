class CreatePartners < ActiveRecord::Migration
  def up
    create_table :partners do |t|
      t.string :name
      t.integer :index
      t.integer :category
      t.boolean :published
      t.integer :city_id
      t.attachment :image

      t.timestamps
    end
    Partner.create_translation_table! :description => :text
  end

  def down
    drop_table :partners
    Partner.drop_translation_table!
  end

end
