class SubdomainController < ApplicationController

  before_filter :retrieve_city

  def index
  end

  private 
  def retrieve_city

    @city = City.find_by_domain(request.subdomains.first.to_s)
    @subscriber = NewsletterSubscriber.new
    @about_path  = article_path(Article.find_with_alias(:about, @city).id)
    @collaboration_path  = article_path(Article.find_with_alias(:collaboration, @city).id)
    @your_place_path  = article_path(Article.find_with_alias(:your_place, @city).id)
    @two_percent_path  = article_path(Article.find_with_alias(:two_percent, @city).id)

    if (Time.now.mday.to_i <= 20 ) 
      time_range = Date.today..Date.today.end_of_month  
    else
      time_range = Date.today..Date.today.end_of_month.next_month
    end
    @this_month_workshops, @next_month_workshops = @city.workshops.active(time_range)
  end


end
