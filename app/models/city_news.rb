class CityNews < ActiveRecord::Base
	belongs_to :city
	belongs_to :news

end
