class SubdomainController < ApplicationController

  before_filter :retrieve_city
  
  def index
  end

  private 
	# .where("workshops.enabled = 1").references(:workshops)
  def retrieve_city
    @city = City.find_by_domain(request.subdomains.first.to_s)
  end
end
