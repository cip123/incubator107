class CreateCityArticles < ActiveRecord::Migration
  def change
    create_table :city_articles do |t|
      t.integer :city_id
      t.integer :article_id  

      t.timestamps
    end

  add_index :city_articles, :article_id
  add_index :city_articles, :city_id
  add_index :city_articles, [:city_id, :article_id], unique: true
  end
end
