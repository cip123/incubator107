class Article < ActiveRecord::Base
  translates :text, :title
  validates :text, presence: true
  validates :title, presence: true
end
