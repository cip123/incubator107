class Registration < ActiveRecord::Base

  belongs_to :person
  belongs_to :event
  default_scope -> {includes :event}
  has_one :workshop, :through => :event
  attr_accessor :subscribe_to_mailing_list

  def schedule_reminder 
    RegistrationMailer.delay(run_at: event.start_date.at_midnight - 16.hours).reminder(self)
  end

end
