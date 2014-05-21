class SetCitiesArticlesForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key(:cities, :cities_article_aliases)
  end
end
