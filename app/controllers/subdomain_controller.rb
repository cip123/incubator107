class SubdomainController < ApplicationController

  before_filter :retrieve_city
  
  def index
  end

  private 

  def retrieve_city
    @city = City.find_by_domain(request.subdomain)
  end
end
