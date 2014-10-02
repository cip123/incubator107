class News < ActiveRecord::Base
  translates :title, :content
  validates :content, presence: true
  validates :title, presence: true
  validates :release_date, presence: true
  default_scope -> {includes :translations}
  belongs_to :city
  has_attached_file :image
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
