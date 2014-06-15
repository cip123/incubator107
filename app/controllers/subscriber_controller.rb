class SubscriberController < SubdomainController


  def register_newsletter
    email =  params[:subscriber][:email]

    subscriber = Subscriber.find_or_create_by(email: email);

    if (subscriber.valid?)
      @response = I18n.t(:thank_you_for_registering)
      MailingListSubscriber.find_or_create_by(mailing_list_id: @city.mailing_list_id, subscriber_id: subscriber.id)
    else
      if subscriber.errors.has_key?(:email)
        @response = subscriber.errors[:email].first
      end
    end
  end

  respond_to do |format|
    format.js
  end


end
