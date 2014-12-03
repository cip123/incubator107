class GroupsController < SubdomainController

  def index
    @page_handle = "workshops"
    @groups = Group.where(active: true).order(:index)
  end

end
