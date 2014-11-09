class GroupsController < SubdomainController

  def index
    @groups = Group.where(active: true).order(:index)
  end

end
