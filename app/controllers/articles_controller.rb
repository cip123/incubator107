class ArticlesController < SubdomainController

  def show
    @article = Article.find(params[:id])
    @page_handle = @article.alias
  end

end
