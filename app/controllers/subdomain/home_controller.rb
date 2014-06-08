class Subdomain::HomeController < SubdomainController
  def index
  	@participant = Participant.new

  	last_news = @city.news.last
  	@last_news_title = last_news.title
  	@last_news_text = last_news.text

  end
end
