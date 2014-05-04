class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :subdomain
      t.string :country
      t.decimal :donation, :precision =>8, :scale => 2
      t.string :facebook

      t.timestamps
    end
  end
end
