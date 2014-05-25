FactoryGirl.define do

  factory :city do
    sequence(:name)  { |n| "City #{n}" }
    # adding 127.0.0.1 because of the way we test subdomain visits
    sequence(:domain) { |n| "city-#{n}.127.0.0.1" }

    factory (:city_with_links) do
       after (:create) do |city, evaluator|
        create(:city_link, name: 'about', city_id: city.id )
        create(:city_link, name: 'workshops', city_id: city.id )
        create(:city_link, name: 'contact', city_id: city.id)
      end
    end


      # TODO is should be only one factory method here
     factory :city_with_english_locale do
      after (:create) do |city, evaluator|
        create(:city_link,  city_id: city.id, article_id: create(:article).id )
        about_article = create(:article, title: 'What is incubator107?')
        
        create(:city_link, name: 'about', city_id: city.id, article_id: about_article.id )

        create(:city_link, name: 'workshops', city_id: city.id, article_id: create(:article, title: 'workshops').id)
        create(:city_link, name: 'contact', city_id: city.id, article_id: create(:article, title: 'Contact').id)
        create(:city_link,  city_id: city.id, article_id: create(:article).id )
      end
    end
    factory :city_with_romanian_locale do
      after (:create) do |city, evaluator|
        create(:city_link,  city_id: city.id, article_id: create(:article).id )
        about_article = create(:article, title: 'Ce e incubator107?')
        
        create(:city_link, name: 'about', city_id: city.id, article_id: about_article.id )

        create(:city_link, name: 'workshops', city_id: city.id, article_id: create(:article, title: 'workshops').id)
        create(:city_link, name: 'contact', city_id: city.id, article_id: create(:article, title: 'Contact').id)
        create(:city_link,  city_id: city.id, article_id: create(:article).id )
      end
    end
  end

  factory :workshop do 
      sequence(:name) { |n| "atelier #{n} " }
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
