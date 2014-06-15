class Group < ActiveRecord::Base
  translates :name
  default_scope -> { includes :translations }
end
