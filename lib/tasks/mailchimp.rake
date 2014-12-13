namespace :mailchimp do
  desc "Create groups to use with mailchimps"

  task :clear_newsletter_list, [:city] => :environment do | t, args| 

    domain = args["city"]
    city = City.find_by_domain domain
    gibbon = Gibbon::API.new(city.mailchimp_key)
    groupings =  gibbon.lists.interest_groupings({ id: city.mailchimp_workshop_list_id})
    grouping_id =  groupings[0]["id"]    
    puts grouping_id
    puts gibbon.lists.interest_grouping_del(grouping_id: grouping_id)

  end

  task :add_newsletter_subscribers, [:city] => :environment do | t, args| 

    domain = args["city"]
    city = City.find_by_domain domain

    emails = NewsletterSubscriber.where(city: city).distinct.pluck(:email)
    puts emails.count
    
    
    batch = []
    emails.each do |email|
      batch.push({ email: { email: email }, merge_vars: {} })
    end

    Gibbon::API.timeout = 60
    gibbon = Gibbon::API.new(city.mailchimp_key)  

    puts gibbon.lists.batch_subscribe({id: city.mailchimp_newsletter_list_id, batch: batch, double_optin: false, replace_interests: false, update_existing: true })

  end

 task :add_workshop_subscribers, [:city] => :environment do | t, args| 

    domain = args["city"]
    city = City.find_by_domain domain

    Group.all.each do |group|
      group_emails = Person.joins(:registrations => {:event => :workshop}).where(city_id: city.id, workshops: { group_id: group.id }).distinct.pluck(:email)      
      batch_subscribe city, group, group_emails
    end

  end

  def batch_subscribe city, group, emails
    
    merge_vars = {
      groupings: [ 
        id: city.mailchimp_workshop_groups_id, 
        groups: [ group.name ] 
      ] 
    }
    
    batch = []
    emails.each do |email|
      batch.push({ email: { email: email }, merge_vars: merge_vars })
    end

    Gibbon::API.timeout = 60
    gibbon = Gibbon::API.new(city.mailchimp_key)    
    puts gibbon.lists.batch_subscribe({id: city.mailchimp_workshop_list_id, batch: batch, double_optin: false, replace_interests: false, update_existing: true })
  end

  task :create_groups, [:city] => :environment do | t, args| 

    domain = args["city"]
    city = City.find_by_domain domain

    gibbon = Gibbon::API.new(city.mailchimp_key)
    if (city.mailchimp_workshop_groups_id.blank?)
      puts "Creating mailchimp grouping for #{city.name}"
      response = gibbon.lists.interest_grouping_add({ id: city.mailchimp_workshop_list_id, name: "Bresle", type: "radio", groups: Group.all.map(&:name) })
      city.mailchimp_workshop_groups_id = response["id"]
      city.save
    end

  end

end
