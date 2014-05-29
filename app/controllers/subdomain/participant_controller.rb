class Subdomain::ParticipantController < SubdomainController

  def subscribe_newsletter
    email =  params[:participant][:email]
    name =  params[:participant][:name]


    subscriber = Subscriber.find_or_initialize_by(email: email);

    if (subscriber.new_record?)
      subscriber.name = name
      subscriber.save
    end

    if (subscriber.valid?)
      @response = I18n.t(:thank_you_for_registering)
      MailingListSubscriber.find_or_create_by(mailing_list_id: @city.mailing_list_id, subscriber_id: subscriber.id)
    else
      if subscriber.errors.has_key?(:email)
        @response = subscriber.errors[:email].first
      else
        @response = subscriber.errors[:name].first
      end
    end
  end

  respond_to do |format|
    format.js
  end
end
