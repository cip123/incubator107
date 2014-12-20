class PartnersController < SubdomainController

  def index
    @page_handle = "partners"
    @broadcasters = Partner.where(published: true, city: @city, category: Partner.categories[:broadcaster]).order(:index)
    @friends = Partner.where(published: true, city: @city, category: Partner.categories[:friend]).order(:index)
  end

end
