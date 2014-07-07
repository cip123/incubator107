class WorkshopsController < SubdomainController


  def show
    @workshop =  Workshop.find(params[:id])
    @workshop_participant = WorkshopParticipant.new
    @workshop_participant.workshop = @workshop
    @workshop_participant.participant = Participant.new
  end


  def signup

    participant = Participant.find_or_initialize_by(email: params[:participant][:email]);

    if (participant.new_record?)
      participant.name = params[:participant][:name]
      participant.phone = params[:participant][:phone]
      if(participant.save) 
        ParticipantMailer.verify_mail(participant, @city.domain).deliver
      end 
    elsif (!participant.verified?)
      @response = I18n.t(:please_validate_your_mail_before_registering)
      return 
    end
    if (participant.valid?)
      @response = I18n.t(:thank_you_for_registering)
      WorkshopParticipant.find_or_initialize_by(participant_id: participant.id, workshop_id: params[:id]) do |workshop_participant|
        workshop_participant.reason = params[:workshop_participant][:reason]
        workshop_participant.display = params[:workshop_participant][:display]
        if(workshop_participant.save && participant.verified?) 
          ParticipantMailer.welcome_mail(participant, params[:id]).deliver
        end
      end

      if params[:workshop_participant][:subscribe_to_mailing_list] == "1"
        subscribe_to_mailing_list(participant)
      end
    else
      if participant.errors.has_key?(:email)
        @response = participant.errors[:email].first
      elsif participant.errors.has_key?(:phone)
        @response = participant.errors[:phone].first
      else
        @response = participant.errors[:name].first
      end
    end
  end

  def index


    @current_group_name = params[:group_id]? Group.find(params[:group_id]).name : I18n.t(:all_groups)  
    puts params[:group_id]

    if params[:group_id] 
      @workshops = Workshop.where(published: true, group_id: params[:group_id], city_id: @city.id).paginate( page: params[:page])
    else
      @workshops = Workshop.where(published: true, city_id: @city.id).paginate( page: params[:page])
    end
    @groups = Group.all
  end

  respond_to do |format|
    format.js
  end
  private 


  def subscribe_to_mailing_list(participant)
    subscriber = Subscriber.find_or_create_by(email: participant.email)
    MailingListSubscriber.create( subscriber_id: subscriber.id, mailing_list_id: @city.mailing_list_id)
  end
end


