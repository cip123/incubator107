class SubdomainController < ApplicationController

  before_filter :retrieve_city
  
  def index
  end

  private 

  def retrieve_city
    puts "retrievieng city for #{request.subdomain} "
    @city = City.find_by_domain(request.subdomain)
    puts @city.inspect
  end
end
