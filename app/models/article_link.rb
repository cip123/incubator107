class ArticleLink < ActiveRecord::Base
	belongs_to :article
  belongs_to :city
end
