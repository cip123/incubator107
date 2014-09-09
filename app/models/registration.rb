class Registration < ActiveRecord::Base

  belongs_to :person
  belongs_to :event
  default_scope -> {includes :event}
  has_one :workshop, :through => :event
  attr_accessor :subscribe_to_mailing_list

  def send_reminder 
    if workshop.should_send_notification
      RegistrationMailer.remind(self)
    end
  end

end
