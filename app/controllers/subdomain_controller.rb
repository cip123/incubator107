class SubdomainController < ApplicationController

  before_filter :retrieve_city
  
  def index
  end

  private 

  def retrieve_city
    @city = City.includes(:workshops).where("workshops.enabled = 1").references(:workshops).find_by_domain(request.subdomain)
  end
end
