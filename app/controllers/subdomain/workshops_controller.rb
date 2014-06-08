class Subdomain::WorkshopsController < SubdomainController


  def show
    @workshop =  Workshop.find(params[:id])
    @workshop_participant = WorkshopParticipant.new
    @workshop_participant.workshop = @workshop
    @workshop_participant.participant = Participant.new
  end


  def signup
    puts params.inspect
    email = params[:participant][:email]
    name = params[:participant][:name]
    phone = params[:participant][:phone]
                       
    participant = Participant.find_or_initialize_by(email: email);

    if (participant.new_record?)
      participant.name = name
      participant.phone = phone
      participant.save
    end
  end

  def index

    @current_group_name = params[:group_id]? Group.find(params[:group_id]).name : I18n.t(:all_groups)  

    if params[:group_id] 
      @workshops = Workshop.where(enabled: true, group_id: params[:group_id], city_id: @city.id).paginate( page: params[:page])
    else
      @workshops = Workshop.where(enabled: true, city_id: @city.id).paginate( page: params[:page])
    end
    @groups = Group.all
  end
  
  respond_to do |format|
    format.js
  end
end
