class Location < ActiveRecord::Base
  translates :name, :address, :description
end

