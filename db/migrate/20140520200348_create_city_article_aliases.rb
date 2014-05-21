class CreateCityArticleAliases < ActiveRecord::Migration
  def change
    create_table :city_article_aliases do |t|
      t.string :name
      t.string :locale
      t.integer :article_id
      t.integer :city_id
      t.foreign_key :articles
      t.foreign_key :cities

      t.timestamps
    end
  end
end
