FactoryGirl.define do

  factory :city do
    sequence(:name)  { |n| "City #{n}" }
    # adding 127.0.0.1 because of the way we test subdomain visits
    sequence(:domain) { |n| "city-#{n}.127.0.0.1" }

    factory :city_with_articles do 
      after (:create) do |city, evaluator|
        create(:city_article_alias,  city_id: city.id, article_id: create(:article).id )
        create(:city_article_alias, name: 'about', city_id: city.id, article_id: create(:article, name: 'Cine suntem').id )
        create(:city_article_alias,  city_id: city.id, article_id: create(:article).id )
      end
    end
  end

  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"


    factory :admin do
      admin true
    end
  end

  factory :city_article_alias do
    name 'test'
  end

  factory  :article do
    sequence(:name)  { |n| "Lorem #{n}" }
    content "Pace pentru fratii mei iubire totdeauna"
    user
  end

end
