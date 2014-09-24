class ArticleLink < ActiveRecord::Base
	belongs_to :article
  belongs_to :city
  enum alias: [ :about, :collaboration, :your_place, :friends, :two_percent ]
end
