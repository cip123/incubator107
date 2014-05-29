FactoryGirl.define do

  factory :city do
    sequence(:name)  { |n| "City #{n}" }
    sequence(:email)  { |n| "email#{n}@incubator107.com" }
    domain "cluj" 
    mailing_list_id 1
    donation 20.0

    factory (:city_with_links) do
       after (:create) do |city, evaluator|
        
        create(:city_link, name: 'about', city_id: city.id )
        create(:city_link, name: 'workshops', city_id: city.id )
        create(:city_link, name: 'contact', city_id: city.id)
        create(:workshop, name: 'active workshop', city_id: city.id , enabled: 1)
        create(:workshop, name: 'inactive workshop', city_id: city.id )
        create(:workshop, name: 'old workshop', city_id: city.id, enabled: 1, release_date: 1.month.ago )
        create(:workshop, name: 'next month workshop', city_id: city.id, enabled: 1, release_date: 1.month.from_now )

      end
    end

  end

  factory :workshop do 
      sequence(:name) { |n| "atelier #{n} " }
      enabled 0
      release_date DateTime.now
  end

  factory :mailing_list do 
      sequence(:name) { |n| "Mailing List #{n} " }      
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

  factory  :article do
    sequence(:title)  { |n| "Lorem #{n}" }
    text "Pace pentru fratii mei iubire totdeauna"
  #  user
  end

  factory :location  do
    sequence(:name)  { |n| "Location_#{n}" }
  end

end
