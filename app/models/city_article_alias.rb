class CityArticleAlias < ActiveRecord::Base
  belongs_to :city
  belongs_to :article
  validates :article_id, presence: true
  validates :city_id, presence: true
end

