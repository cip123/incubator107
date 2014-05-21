class CreateArticlesCitiesJoinTable < ActiveRecord::Migration
  def change
    create_table :articles_cities, :id => false do |t|
      t.integer :article_id
      t.integer :city_id
      t.string :name
    end
  end
end
