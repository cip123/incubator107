class Subdomain::HomeController < SubdomainController
  def index
  	@participant = Participant.new
  end
end
