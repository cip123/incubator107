class PartnersController < SubdomainController

  def index
    @partners = Partner.where(published: true, city: @city).order(:index)
  end

end
