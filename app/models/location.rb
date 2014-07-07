class Location < ActiveRecord::Base
  translates :name, :address, :description

  	belongs_to :city
	geocoded_by :address
	after_validation :geocode

	validates :name, presence: true, length: { maximum: 50 }

end

