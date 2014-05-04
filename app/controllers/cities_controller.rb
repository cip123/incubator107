class CitiesController < ApplicationController
  def new
  end

  def index
    @cities = City.all
  end

end
