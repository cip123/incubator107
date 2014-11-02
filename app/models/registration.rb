class Registration < ActiveRecord::Base

  belongs_to :person
  validates :person, presence: true

  belongs_to :event
  validates :event, presence: true

  default_scope -> {includes :event}
  has_one :workshop, :through => :event
  attr_accessor :subscribe_to_mailing_list

  def send_reminder 

    if workshop.should_send_notification
      RegistrationMailer.remind(self).deliver
      self.notification_sent = true
      self.save!
    end
  end

end
