class City < ActiveRecord::Base
  translates :name, :donation_alternative

  has_many :article_links
  has_many :city_admins
  has_many :city_news
  has_many :news, :through => :city_news, source: :news
  has_many :events, :through => :workshops
  has_one :mailing_list
  has_many :workshops
  has_many :locations
  has_many :contact_persons
  has_and_belongs_to_many :users
  
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  validates :domain, presence: true, length: { maximum: 10 }
  validates :mailing_list_id, presence: true
  validates :facebook, presence: true

  validates_numericality_of :donation, :greater_than_or_equal_to => 0 
  
  def article_links
    City.joins(:article_links).pluck(:alias, :article_id)
  end
end
