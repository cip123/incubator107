class PartnersController < SubdomainController

  def index
    @page_handle = "friends"
    @broadcasters = Partner.where(published: true, city: @city, category: Partner.categories[:broadcaster]).order(:index)
    @friends = Partner.where(published: true, city: @city, category: Partner.categories[:friend]).order(:index)
  end

end
