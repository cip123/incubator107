class WorkshopParticipant < ActiveRecord::Base
  attr_accessor :subscribe_newsletter 
  belongs_to :workshop
  belongs_to :participant
end
