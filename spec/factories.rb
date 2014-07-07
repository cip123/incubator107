FactoryGirl.define do

  factory :city do
    sequence(:name)  { |n| "City #{n}" }
    sequence(:email)  { |n| "email#{n}@incubator107.com" }
    domain "cluj" 
    facebook "incubator107"
    location_id 1
    mailing_list_id 1
    donation 20.0
    donation_alternative "<p>daca <b>nu</b> va</p>" 
    factory (:city_with_links) do
       after (:create) do |city, evaluator|
        create(:city_news, news_id: create(:news, title: "Last news").id, city_id: city.id )        
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
      group_id 1 
      published 1
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
  end


  factory :participant do
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


  factory :mailing_list do 
      sequence(:name) { |n| "Mailing List #{n}" }      
  end

  factory :article_link do
    sequence(:alias)  { |n| "link_#{n}" }
    article_id 1
  end

  factory :city_news do
    news_id 1
    city_id 1
  end

  factory :news do
    sequence(:title)  { |n| "Lorem #{n}" }
    text "<p>breaking news </p>"
    release_date DateTime.now
  end


  factory  :article do
    sequence(:title)  { |n| "Lorem #{n}" }
    text "Pace pentru fratii mei iubire totdeauna"
  #  user
  end

  factory :location  do
    sequence(:name)  { |n| "Location_#{n}" }
  end

  factory :workshop_participant do
    workshop_id 1
    participant_id 1
    display 0
    reason "decembrie"
  end


  factory :user do
    sequence(:name) { |n| "user #{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    role 0
  end

  factory :super_admin_user, class: User do
    name "Super User" 
    email "super@example.com"
    password "foobar"
    password_confirmation "foobar"
    role 1
  end

  factory :local_admin_user, class: User do
    sequence(:name) { |n| "local #{n}" }
    sequence(:email) { |n| "local#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    role 2
  end

  factory :city_admin do
    city_id 1
    user_id 2
  end


end
