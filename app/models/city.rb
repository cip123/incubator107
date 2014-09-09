class City < ActiveRecord::Base
  translates :name, :donation_text

  belongs_to :default_location, class_name: "Location"

  has_many :article_links
  has_many :city_groups
  has_many :contact_people
  has_many :news
  has_many :events, :through => :workshops
  
  has_many :workshops

  has_many :locations
  has_many :contact_persons
  
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  validates :name, presence: true, length: { maximum: 50 }
  validates :domain, presence: true

  default_scope -> {includes :translations}
  
  def add_to_mailchimp_newsletter person
    
    return if mailchimp_key.blank?
    
    gibbon = Gibbon::API.new(mailchimp_key)    
    puts gibbon.lists.subscribe({id: newsletter_list_id, email: { email: person.email }, merge_vars: {}, double_optin: false, replace_interests: false, update_existing: true })


  end


end
