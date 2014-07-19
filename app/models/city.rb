class City < ActiveRecord::Base
  translates :name, :donation_text

  belongs_to :default_location, class_name: "Location"

  has_many :article_links
  has_many :contact_people
  has_many :news
  has_many :events, :through => :workshops
  
  belongs_to :mailing_list
  
  has_many :workshops

  has_many :locations
  has_many :contact_persons
  has_and_belongs_to_many :users
  
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  validates :mailing_list_id, presence: true
  validates :facebook, presence: true

  default_scope -> {includes :translations}
  
end
