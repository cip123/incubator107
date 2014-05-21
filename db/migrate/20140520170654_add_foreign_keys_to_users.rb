class AddForeignKeysToUsers < ActiveRecord::Migration
  def change
    add_foreign_key( :articles_cities, :cities, column: 'city_id')
    add_foreign_key( :articles_cities, :articles, column: 'article_id')
  end
end
