class MailingList < ActiveRecord::Base
  has_many :subscribers
  has_one :city

  def subscribe person
    Subscriber.find_or_create_by( mailing_list_id: id, email: person.email)


    mailchimp = Mailchimp::API.new(@city.mail_chimp_key)
    puts mailchimp.lists.list[:data]

    hash = JSON.parse mailchimp.lists.list[:data]
    puts hash


      # mailchimp.lists.subscribe(MAILCHIMP-LIST-ID, 
      #                { "EMAIL" => { "email" => awais545@gmail.com,
      #                  "EUID" => "123",
      #                  "LEID" => "123123"
      #                })

  end

  
end
