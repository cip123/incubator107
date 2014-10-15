class HomeController < SubdomainController
  def index

    @subscriber = NewsletterSubscriber.new
    @last_news = @city.news.last

    if (Time.now.mday.to_i <= 20 ) 
      time_range = Date.today.at_beginning_of_month..Date.today.end_of_month  
    else
      time_range = Date.today.at_beginning_of_month..Date.today.end_of_month.next_month
    end

    @this_month_workshops, @next_month_workshops = @city.workshops.published(time_range)

  end
end
