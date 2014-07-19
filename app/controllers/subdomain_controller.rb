class SubdomainController < ApplicationController

  before_filter :retrieve_city

  def index
  end

  private 
  def retrieve_city
    @city = City.find_by_domain(request.subdomains.first.to_s)

    @about_path  = article_path(@city.article_links.find_by_alias(:about).article_id)
    @collaboration_path  = article_path(@city.article_links.find_by_alias(:collaboration).article_id)
    @your_place_path  = article_path(@city.article_links.find_by_alias(:your_place).article_id)
    @friends_path  = article_path(@city.article_links.find_by_alias(:friends).article_id)
    @two_percent_path  = article_path(@city.article_links.find_by_alias(:two_percent).article_id)

    if (Time.now.mday.to_i <= 20 ) 
      time_range = Date.today.at_beginning_of_month..Date.today.end_of_month  
    else
      time_range = Date.today.at_beginning_of_month..Date.today.end_of_month.next_month
    end
    @this_month_workshops, @next_month_workshops = @city.workshops.published(time_range)
  end
end
