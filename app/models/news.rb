class News < ActiveRecord::Base
  translates :title, :content
  validates :content, presence: true
  validates :title, presence: true
  validates :release_date, presence: true
  default_scope -> {includes :translations}
  belongs_to :city
end
