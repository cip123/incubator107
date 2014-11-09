class Partner < ActiveRecord::Base
  translates :description
  default_scope -> {includes :translations}
  belongs_to :city
  has_attached_file :image
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  enum category: [:friend, :broadcaster ]
end
