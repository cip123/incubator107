class WorkshopRequest < ActiveRecord::Base
  belongs_to :workshop
  belongs_to :person
  attr_accessor :subscribe_to_mailing_list
  
end
