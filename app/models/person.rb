class Person < ActiveRecord::Base
  before_save { self.email = email.downcase }
  belongs_to :city
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, :presence => true, :format => { :with => /^[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+$/i, :multiline => true }, :uniqueness =>  { case_sensitive: false,}
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone, presence: true, length: { maximum: 50 }
  validates :city, presence: true
  has_many :registrations
  has_many :workshop_requests

  def self.create_if_missing (params)

    person = find_or_initialize_by(email: params[:email])

    if (person.new_record?)
      first_request = true
      person.name = params[:name]
      person.phone = params[:phone]
      person.city = params[:city]
      first_request = true
      if(person.save!) 
        PersonMailer.delay.verify(person)
      end 
    else 
      first_request = false
    end
    
    return person, first_request

  end

end
