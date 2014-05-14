FactoryGirl.define do

  factory :city do
    sequence(:name)  { |n| "City #{n}" }
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

  factory  :article do
    content "Lorem ipsum"
    user
  end

end
