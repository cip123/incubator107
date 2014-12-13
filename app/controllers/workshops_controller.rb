class WorkshopsController < SubdomainController



  def show
    @page_handle = "workshops"
    @workshop =  Workshop.find(params[:id])
  
    if (@workshop.active?) 
      @registration = Registration.new( :person => Person.new)
    else      
     @workshop_request = WorkshopRequest.new(:workshop => @workshop)
     @workshop_request.build_person
    end

    if (@workshop.facebook_album_id.present?)
      @graph = Koala::Facebook::API.new( ENV["FACEBOOK_APP_TOKEN"] )
       # @albums = @graph.api("193875377299310/albums?limit=1000&fields=name,id")["data"]
       #  puts @albums
      @photos = @graph.api("/#{@workshop.facebook_album_id}/photos?fields=source,picture")["data"]
    end

  end


  def signup

    person_params = registration_params[:person]
    person_params[:city] = @city

    (person, first_registration) = Person.create_if_missing(person_params)

    workshop = Workshop.find(params[:id]);

    if registration_params[:subscribe_to_mailing_list] == "1"
      NewsletterSubscriber.find_or_create_by( city_id: @city.id, email: person.email)
      @city.delay.add_to_mailchimp_newsletter person
    end

    if (first_registration  || person.verified)

      succesfull_registration = false

      params[:event_ids].each do |event_id|
        
        Registration.find_or_initialize_by(person_id: person.id, event_id: event_id) do |registration|
          if registration.new_record? 
            registration.reason = registration_params[:reason]
            succesfull_registration = true
            registration.save!
            # this scheduling is done here because the mailers do not support run_at: parameter at the moment
            registration.delay(run_at: registration.event.start_date.at_midnight - 16.hours).send_reminder 
          end
        end
      end
    
      RegistrationMailer.delay.confirm(:person => person, :workshop => workshop) if succesfull_registration && person.verified

      workshop.group.delay.add_to_mailchimp person

      @response = I18n.t(:thank_you_for_registering)

    else
      @response = I18n.t(:please_validate_your_mail_before_registering)
      return 
    end

  end


  def index

    @page_handle = "workshops"

    @current_group_name = params[:group_id]? Group.find(params[:group_id]).name : I18n.t(:all_groups)  
    
    @current_page = params[:page]? 1 : params[:page]

    if params[:group_id] 
      @workshops = Workshop.joins(:translations).where(published: true, group_id: params[:group_id], city_id: @city.id).order("name asc").paginate( page: params[:page])
    else
      @workshops = Workshop.joins(:translations).where(published: true, city_id: @city.id)..order("name asc").paginate( page: params[:page])
    end
    @groups = Group.all
  end

  respond_to do |format|
    format.js
  end

  private 

  def registration_params
    params.require(:registration).permit( :reason, :subscribe_to_mailing_list, :person => [:name, :email, :phone], :workshop => [:id])
  end

end


