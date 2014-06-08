class Subdomain::ArticlesController < SubdomainController

  def show
    @article = Article.find(params[:id])
  end

end
