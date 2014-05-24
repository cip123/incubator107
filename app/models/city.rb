class City < ActiveRecord::Base
  has_many :article_aliases, foreign_key: 'city_id', :class_name => "CityArticleAlias"

  def about_article_id 
    return self.article_aliases.find_by(name: "about", locale: I18n.locale).article_id
  end

  def contact_article_id 
    return self.article_aliases.find_by(name: "contact", locale: I18n.locale).article_id
  end
end
