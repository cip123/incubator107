class ContactPerson < ActiveRecord::Base
  belongs_to :city
  translates :about, :title, :team
  default_scope -> { order :index }
end
