class City < ActiveRecord::Base
  translates :name

  has_many :city_links
  has_many :workshops

  def about_article_id
    return self.city_links.find_by_name(:about).article_id
  end

  def contact_article_id
      return self.city_links.find_by_name(:contact).article_id
  end
end
