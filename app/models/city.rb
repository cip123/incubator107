class City < ActiveRecord::Base
  has_many :article_aliases, foreign_key: 'city_id', :class_name => "CityArticleAlias"

  def about_article_id 
    return self.article_aliases.find_by_name(:about).article_id
  end

end
