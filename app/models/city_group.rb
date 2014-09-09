class CityGroup < ActiveRecord::Base
  belongs_to :city
  belongs_to :group

end
