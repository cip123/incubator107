class NewsController < SubdomainController

  def show
    @news =  News.find(params[:id])
  end

end


