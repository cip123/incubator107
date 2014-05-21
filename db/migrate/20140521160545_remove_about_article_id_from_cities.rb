class RemoveAboutArticleIdFromCities < ActiveRecord::Migration
  def change
    remove_column :cities, :about_article_id
  end
end
