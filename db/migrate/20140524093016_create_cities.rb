class CreateCities < ActiveRecord::Migration
  def up
    create_table :cities do |t|
      t.string :domain
      t.string :country
      t.decimal :donation, precision: 8, scale: 2
      t.string :facebook
    
      t.timestamps
    end

    City.create_translation_table! :name => :string
  end

  def down
    drop_table :cities
    City.drop_translation_table!
  end

end
