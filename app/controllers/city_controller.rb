class CityController < ApplicationController
  def index

    @cities = City.all
    render :layout => false
  end
end
