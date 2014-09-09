class RegistrationMailer < ActionMailer::Base
  default from: "inscrieri@incubator107.com"

  def confirm(params ={} )

    person = params[:person]
    @workshop = params[:workshop]
    
    mail(to: person.email, subject: "#{@workshop.name} - #{I18n.t(:online_registration)}")
  end

  def remind(registration)


    person = registration.person
    @workshop = registration.event.workshop

    @your_place_article = @workshop.city.article_links.where( alias: :your_place ).first
    @city_url = "http://#{@workshop.city.domain}.#{Rails.configuration.hosts[Rails.env]}";

    mail(to: person.email, subject: "Reminder - #{@workshop.name} - #{registration.event.name}")
  end

end
