

FactoryGirl.define do

  factory :city do
    sequence(:name)  { |n| "City #{n}" }
    sequence(:email)  do |n| 
      index= '%02i' % n
      "email#{index}@incubator107.com" 
    end 
    domain "cluj" 
    sequence(:facebook_page_id ) { |n| "100000000#{n}" }
    sequence(:default_event_location_id ) { |n| "#{n}" }
    sequence(:mailchimp_key ) { |n| "mailchimp key#{n}" }
    sequence(:mailchimp_newsletter_list_id ) { |n| "newsletter list #{n}" }
    sequence(:mailchimp_workshop_list_id ) { |n| "workshop list #{n}" }
    sequence(:mailchimp_workshop_groups_id ) { |n| "workshop groups #{n}" }
    sequence(:default_donation ) { |n| "donation for <strong>#{n}</strong>" }
    sequence(:default_whereabouts ) { |n| "whereabouts for <strong>#{n}</strong>" }

    factory (:city_with_links) do
       after (:create) do |city, evaluator|
        create(:news, title: "Last news", city_id: city.id )
        create(:article, alias: Article.aliases[:about])        
        create(:article, alias: Article.aliases[:collaboration])
        create(:article, alias: Article.aliases[:your_place])
        create(:article, alias: Article.aliases[:two_percent])
        create(:workshop, name: 'active workshop', city_id: city.id , published: 1)
        create(:workshop, name: 'inactive workshop', city_id: city.id )
        create(:workshop, name: 'old workshop', city_id: city.id, published: 1, release_date: 1.month.ago )
        create(:workshop, name: 'next month workshop', city_id: city.id, published: 1, release_date: 1.month.from_now )
      end
    end

  end

  factory :workshop do 
      sequence(:name) { |n| "atelier #{n}" }
      city_id 1 
      group
      published 1
      sequence(:facebook_album_id) { |n| "1000#{n}" }
      description "<p>description<b>test<b></p>"
      bring_along "<p>requisite<span>test</span></p>" 
      with_whom "<p> master<b>test</b></p>"
      whereabouts "<p> where<b>test</b></p>"
      requires_donation true
      should_send_notification true

      donation "<p> donation<b>test</b></p>"
      release_date DateTime.now
      factory (:workshop_with_events) do
        after(:create) do | workshop, evaluator|
          create(:event, workshop_id: workshop.id, start_date: Date.today.at_beginning_of_month + 10.days)
          create(:event, workshop_id: workshop.id, start_date: Date.today.at_beginning_of_month + 20.days)
          create(:event, workshop_id: workshop.id, start_date: Date.today.at_beginning_of_month + 35.days)
        end
      end

      factory (:workshop_with_events_in_the_past) do
        after(:create) do | workshop, evaluator|
          create(:event, workshop_id: workshop.id, start_date: Date.today.at_beginning_of_month - 10.days)
          create(:event, workshop_id: workshop.id, start_date: Date.today.at_beginning_of_month - 20.days)
          create(:event, workshop_id: workshop.id, start_date: Date.today.at_beginning_of_month - 35.days)
        end
      end

  end

  factory :workshop_request do
    person
    workshop
    sequence(:reason) { |n| "reason no. #{n}" }
  end

  factory :person do
    sequence(:name) { |n| "contact #{n}" }
    sequence(:email) do |n| 
      index= '%02i' % n
      "email#{index}@test.ro" 
    end 
    sequence(:phone) { |n| "07000010#{n}" }
    city_id 1
  end

  factory :group do
      sequence(:name) { |n| "group #{n}" }
      active true
  end

  factory :contact_person do
    sequence(:name) { |n| "contact #{n}" }
    sequence(:email) do |n| 
      index= '%02i' % n
      "email#{index}@test.ro" 
    end 
    sequence(:title) { |n| "title #{n}" }
    sequence(:about) { |n| "about #{n}" }
    sequence(:phone) { |n| "phone #{n}" }
    sequence(:team) { |n| "team #{n}" }
    sequence(:index) { |n| n }
    city_id 1
  end

  factory (:event) do
    workshop_id 1
    start_date DateTime.now
    duration 120
    location
  end

  factory :news do
    sequence(:title)  { |n| "Lorem #{n}" }
    content "<p>breaking news </p>"
    city_id 1
    release_date DateTime.now
  end


  factory  :article do
    sequence(:title)  { |n| "Lorem #{n}" }
    content "Pace pentru fratii mei iubire totdeauna"
  end

  factory :location  do
    sequence(:name)  { |n| "Location_#{n}" }
  end

  factory :registration do
    event_id 1
    person_id 1
    reason "decembrie"

  end

  factory :user do
    sequence(:name) { |n| "user #{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    role 0
  end


end
