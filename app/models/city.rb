class City < ActiveRecord::Base
  translates :name, :donation_alternative
  #includes(:city_links)

  has_many :city_links
  has_many :city_news
  has_many :news, :through => :city_news, source: :news
  has_one :mailing_list
  has_many :workshops, -> { where enabled: true } 
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  validates :domain, presence: true, length: { maximum: 10 }
  validates :mailing_list_id, presence: true
  validates :facebook, presence: true

  validates_numericality_of :donation, :greater_than_or_equal_to => 0 
  
  #default_scope -> { where(enabled: 1) }


  def about_article_id
    return self.city_links.find_by_name(:about).article_id
  end

  def contact_article_id
      return self.city_links.find_by_name(:contact).article_id
  end

  def collaboration_article_id
    return self.city_links.find_by_name(:collaboration).article_id
  end

  def your_place_article_id
    return self.city_links.find_by_name(:your_place).article_id
  end

  def friends_article_id
    return self.city_links.find_by_name(:friends).article_id
  end

  def two_percent_article_id
    return self.city_links.find_by_name(:two_percent).article_id
  end

end
