class Article < ActiveRecord::Base

  translates :content, :title
  validates :content, presence: true
  validates :title, presence: true
  belongs_to :city
  default_scope -> {includes :translations}
  enum alias: [ :about, :collaboration, :your_place, :two_percent ]

  def self.find_with_alias article_alias, city
    at = Article.arel_table
    articles = Article.where(at[:alias].eq(Article.aliases[article_alias]).and(at[:city_id].eq(city.id).or(at[:city_id].eq(nil))))
    articles.each do |article|
      return article if article.city == city 
    end

    return articles[0]
  end
end

