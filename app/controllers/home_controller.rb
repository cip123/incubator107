class HomeController < SubdomainController
  def index
    @latest_news = News.where(published: true, city_id: @city.id).order(release_date: :desc).limit(11).to_a
    @last_news = @latest_news.shift
  end
end
