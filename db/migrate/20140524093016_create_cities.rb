class CreateCities < ActiveRecord::Migration
  def up
    create_table :cities do |t|
      t.string :domain
      t.string :country
      t.string :facebook
      t.string :email
      t.integer :default_location_id
      t.integer :mailing_list_id
      t.string :google_analytics_code

      t.timestamps
    end
    add_index :cities, :email, unique: true
    add_index :cities, :domain, unique: true
    City.create_translation_table! :name => :string, :donation_text => :text
  end

  def down
    drop_table :cities
    City.drop_translation_table!
  end

end
