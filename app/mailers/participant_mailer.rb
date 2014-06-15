class ParticipantMailer < ActionMailer::Base
  default from: "inscrieri@incubator107.com"

  def welcome_mail(participant, workshop_id)
    @participant = participant
    @workshop = Workshop.find(workshop_id)
    mail(to: @participant.email, subject: "#{@workshop.name} - #{I18n.t(:online_registration)}")
  end

  def verify_mail(participant, domain)
    @participant = participant
    crypt = ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
    encrypted_data = crypt.encrypt_and_sign(participant.id)
    @url = "http://#{domain}.#{Rails.configuration.hosts[Rails.env]}/verify?token=#{encrypted_data}"
    puts @url.inspect
    mail(to: @participant.email, subject: I18n.t(:verification_email))
  end
end
