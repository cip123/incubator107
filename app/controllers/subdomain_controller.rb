class SubdomainController < ApplicationController

  before_filter :retrieve_city

  def index
  end

  private 
  def retrieve_city
    @city = City.find_by_domain(request.subdomains.first.to_s)

    @article_links = Hash.new
    @city.article_links.each do |entry|
      @article_links[entry[0]] = entry[1] 
    end

    if (Time.now.mday.to_i <= 20 ) 
      time_range = Date.today.at_beginning_of_month..Date.today.end_of_month  
    else
      time_range = Date.today.at_beginning_of_month..Date.today.end_of_month.next_month
    end
    @this_month_workshops, @next_month_workshops = Workshop.published(time_range)
  end
end
