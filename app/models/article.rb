class Article < ActiveRecord::Base

  translates :content, :title
  validates :content, presence: true
  validates :title, presence: true
  belongs_to :city
  default_scope -> {includes :translations}

end
