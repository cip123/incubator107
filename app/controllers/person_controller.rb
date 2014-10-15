class PersonController < SubdomainController

  def verify
    crypt = ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
    person_id = crypt.decrypt_and_verify(params[:token])
    person = Person.find(person_id)
    if !person.verified?
      person.verified = true
      send_pending_mail(person)
    end
    person.save


  end

  private
  def send_pending_mail (person)

    # we only look at the first registration because we won't allow the users to register multiple registrations without validation
    registration = Registration.find_by_person_id(person.id)

    if registration
      RegistrationMailer.confirm(:person => person, :workshop => registration.workshop).deliver
    end
  end
end
