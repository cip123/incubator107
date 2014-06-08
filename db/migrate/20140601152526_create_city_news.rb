class CreateCityNews < ActiveRecord::Migration
  def change
    create_table :city_news do |t|
      t.integer :city_id
      t.integer :news_id

      t.timestamps
    end

    add_index :city_news, :news_id
    add_index :city_news, :city_id
    add_index :city_news, [:city_id, :news_id], unique: true

  end
end
