class ContactPerson < ActiveRecord::Base
  translates :about, :title, :team
  default_scope -> { order :index }
end
