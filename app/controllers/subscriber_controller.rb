class SubscriberController < SubdomainController


  def register_newsletter

    email =  params[:newsletter_subscriber][:email]
    subscriber = NewsletterSubscriber.find_or_create_by(city: @city, email: email)

    if (subscriber.valid?)
      @response = I18n.t(:thank_you_for_registering)
    else
      @response = subscriber.errors[:email].first
    end
  end

  respond_to do |format|
    format.js
  end


end
