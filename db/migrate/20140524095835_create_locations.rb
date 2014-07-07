class CreateLocations < ActiveRecord::Migration
  def up 
    create_table :locations do |t|
      t.integer :city_id
      t.string :url
      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    Location.create_translation_table! :name => :string, :address => :text, :description => :text
  end
end
