class HomeController < ApplicationController
  
  #layout false

  def index
  end

  def city
    @city = City.find_by_domain(request.subdomain)
    puts @city.inspect
  end
end

