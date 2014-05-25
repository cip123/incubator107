class CreateCityLinks < ActiveRecord::Migration
  def change
    create_table :city_links do |t|
      t.string :name
      t.integer :city_id
      t.integer :article_id

      t.timestamps
    end
  
  add_index :city_links, :name
  add_index :city_links, :city_id
  add_index :city_links, [:city_id, :name], unique: true

  end

end
