class CityController < ApplicationController
  def index
    @cities = City.where(active: true).to_a
    @cities.sort! { |a,b| a.name <=> b.name }
    render :layout => false
  end
end
