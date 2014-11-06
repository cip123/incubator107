class ContactPerson < ActiveRecord::Base
  belongs_to :city
  translates :about, :title, :team
  default_scope -> { order :index }
  has_attached_file :picture
  validates_attachment :picture, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
