class ArticlesController < SubdomainController

  layout :determine_layout

  def index
  	@articles = Article.paginate( page: params[:page]) 	
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  private
  def determine_layout
    admin_actions = [ "index", "edit"] 
    admin_actions.include?(action_name) ? "admin" : "application"
  end

end
