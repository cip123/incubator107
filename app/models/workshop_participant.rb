class WorkshopParticipant < ActiveRecord::Base
  attr_accessor :subscribe_to_mailing_list 
  belongs_to :workshop
  belongs_to :participant
end
