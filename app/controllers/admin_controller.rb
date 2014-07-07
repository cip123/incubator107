
class AdminController < SubdomainController



  before_filter :retrieve_city

  def home
    if (!signed_in?)
      redirect_to '/signin'
    end
  end

  private

  def retrieve_city
    @city = City.find_by_domain(request.subdomains.first.to_s)
  end

  #filter
  def admin_user
    redirect_to signin_path unless current_user && current_user.admin?(@city)
  end


end
