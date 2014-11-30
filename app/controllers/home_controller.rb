class HomeController < SubdomainController
  def index

    
    @last_news = @city.news.last

  end
end
