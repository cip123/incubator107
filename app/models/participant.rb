class Participant < ActiveRecord::Base
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone, presence: true, length: { maximum: 50 }
  has_many :workshop_participants
  has_many :workshops, :through => :workshop_participants

  accepts_nested_attributes_for :workshop_participants, :allow_destroy => true

end
