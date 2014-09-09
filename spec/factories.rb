FactoryGirl.define do

  factory :city do
    sequence(:name)  { |n| "City #{n}" }
    sequence(:email)  { |n| "email#{n}@incubator107.com" }
    domain "cluj" 
    facebook_page_id "1232132132"
    default_location_id 1
    mailchimp_key "test-key"
    newsletter_list_id "tewrwrw"
    workshop_list_id "ewew"
    workshop_groups_id 123123

    donation_text "<p>daca <b>nu</b> va</p>" 
    factory (:city_with_links) do
       after (:create) do |city, evaluator|
        create(:news, title: "Last news", city_id: city.id )
        create(:article_link, alias: 'about', city_id: city.id )        
        create(:article_link, alias: 'collaboration', city_id: city.id )
        create(:article_link, alias: 'your_place', city_id: city.id )
        create(:article_link, alias: 'friends', city_id: city.id )
        create(:article_link, alias: 'two_percent', city_id: city.id )
        create(:article_link, alias: 'contact', city_id: city.id)
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


  factory :person do
    name "ciprian"
    email "cip@incubator107.com"
    phone "0748452880"
  end

  factory :group do
      sequence(:name) { |n| "group #{n}" }
  end

  factory :contact_person do
    sequence(:name) { |n| "contact #{n}" }
    sequence(:email) { |n| "email#{n}@test.ro" }
    sequence(:title) { |n| "title #{n}" }
    sequence(:about) { |n| "about #{n}" }
    city_id 1
  end

  factory (:event) do
    workshop_id 1
    start_date DateTime.now
    duration 120
    location
  end

  factory :article_link do
    sequence(:alias)  { |n| "link_#{n}" }
    article_id 1
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
  #  user
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
