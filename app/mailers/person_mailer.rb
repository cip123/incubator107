class PersonMailer < ActionMailer::Base

  default from: "inscrieri@incubator107.com"

  def verify(person)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
    encrypted_data = crypt.encrypt_and_sign(person.id)
    @url = "http://#{person.city.domain}.#{Rails.configuration.hosts[Rails.env]}/verify?token=#{encrypted_data}"
    mail(to: person.email, subject: I18n.t(:verification_email))
  end
end
