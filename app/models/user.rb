class User < ActiveRecord::Base

  before_save do
    self.email = email.downcase
  end

  before_create :create_remember_token

  has_and_belongs_to_many :cities

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  has_secure_password

  # todo why password is always nil if the password string is empty
  validates :password, length: { minimum: 6 }, :if => lambda{ new_record? || !password_confirmation.nil? }

  enum role: [ :regular, :super_admin, :local_admin, :master ]

  has_and_belongs_to_many :cities

  def assignable_roles
    return { "None" => :regular,"Admin" => :super_admin, "Local admin" => :local_admin }
  end

  attr_accessor :admin

  def admin?(city)
    return super_admin? || local_admin_for?(city)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


  def local_admin_for?(city)
    return  local_admin? && city.users.include?(self)
  end

  def send_password_reset

    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end


end
