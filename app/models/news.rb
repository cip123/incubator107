class News < ActiveRecord::Base
  translates :text, :title
  validates :text, presence: true
  validates :title, presence: true
  validates :release_date, presence: true
end
