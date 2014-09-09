
class WorkshopRequestsController < SubdomainController

  def show

  end


  def create

    person_params = request_params[:person]
    person_params[:city] = @city

    workshop_id = request_params[:workshop][:id]
    workshop = Workshop.find(workshop_id);


    (person, first_request) = Person.create_if_missing(person_params)

    if request_params[:subscribe_to_mailing_list] == "1"
      NewsletterSubscriber.find_or_create_by( city_id: @city.id, email: person.email)
      @city.delay.add_to_mailchimp_newsletter person
    end

    if (first_request  || person.verified)

      WorkshopRequest.find_or_initialize_by(person_id: person.id, workshop_id: workshop_id) do |workshop_request|
        workshop_request.reason = request_params[:reason]
        workshop_request.save
      end

      workshop_request_count = WorkshopRequest.count(:conditions => "workshop_id = #{workshop_id}")

      if (workshop_request_count % 10) == 0
        WorkshopRequestMailer.delay.notify(:count => workshop_request_count, :workshop => workshop)
      end

      workshop.group.delay.add_to_mailchimp person

      @response = I18n.t(:thank_you)

    else
      @response = I18n.t(:please_validate_your_mail_before_registering)
      return 
    end

  end


  respond_to do |format|
    format.js
  end
  

  def request_params
    params.require(:workshop_request).permit( :reason, :subscribe_to_mailing_list, :person => [:name, :email, :phone], :workshop => [:id])
  end

end
