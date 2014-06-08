FactoryGirl.define do

  factory :city do
    sequence(:name)  { |n| "City #{n}" }
    sequence(:email)  { |n| "email#{n}@incubator107.com" }
    domain "cluj" 
    facebook "incubator107"
    mailing_list_id 1
    donation 20.0
    donation_alternative "<p>daca <b>nu</b> va</p>" 
    factory (:city_with_links) do
       after (:create) do |city, evaluator|
        
        create(:city_news, news_id: create(:news, title: "Last news").id, city_id: city.id )        
        create(:city_link, name: 'about', city_id: city.id )        
        create(:city_link, name: 'collaboration', city_id: city.id )
        create(:city_link, name: 'your_place', city_id: city.id )
        create(:city_link, name: 'friends', city_id: city.id )
        create(:city_link, name: 'two_percent', city_id: city.id )
        create(:city_link, name: 'contact', city_id: city.id)
        create(:workshop, name: 'active workshop', city_id: city.id , enabled: 1)
        create(:workshop, name: 'inactive workshop', city_id: city.id )
        create(:workshop, name: 'old workshop', city_id: city.id, enabled: 1, release_date: 1.month.ago )
        create(:workshop, name: 'next month workshop', city_id: city.id, enabled: 1, release_date: 1.month.from_now )

      end
    end

  end

  factory :workshop do 
      sequence(:name) { |n| "atelier #{n}" }
      city_id 1 
      group_id 1 
      enabled 1
      description "<p>description<b>test<b></p>"
      bring_along "<p>requisite<span>test</span></p>" 
      with_whom "<p> master<b>test</b></p>"
      whereabouts "<p> where<b>test</b></p>"
      requires_donation true
      donation "<p> donation<b>test</b></p>"
      release_date DateTime.now
      factory (:workshop_with_events) do
        after(:create) do | workshop, evaluator|
          create(:event, workshop_id: workshop.id )
          create(:event, workshop_id: workshop.id, start_date: 7.days.from_now)
          create(:event, workshop_id: workshop.id, start_date: 14.days.from_now)
        end
      end
  end

  factory :group do
      sequence(:name) { |n| "group #{n}" }
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


  #factory :user do
  #  sequence(:name)  { |n| "Person #{n}" }
  #  sequence(:email) { |n| "person_#{n}@example.com"}
  #  password "foobar"
  #  password_confirmation "foobar"


  #  factory :admin do
  #    admin true
  #  end
  #end

  factory :city_link do
    sequence(:name)  { |n| "link_#{n}" }
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

end
