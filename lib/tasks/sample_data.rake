namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
#    user = User.create!(name: "Ciprian",
#                        email: "cip@trusca.net",
#                        password: "foobar",
#                        password_confirmation: "foobar",
#                        admin: true 
#                       )
    Article.create!(title: "Ce e incubator107?",
                   text: Faker::Lorem.paragraph,
                   )

    Article.create!(title: "What is incubator 107?",
                    text: Faker::Lorem.paragraph,
                   )

    about_cluj = Article.create!(title: "Cine suntem",
                    text: Faker::Lorem.paragraph,
                   )

    City.create(name: 'Cluj',
                domain: 'cluj',
               )

    City.create(name: (I18n.t 'bucharest'),
                domain: 'bucuresti'
               )

    CityLink.create!( name: 'about',
                             city_id: 1,
                             article_id: 1)

    CityLink.create!( name: 'contact',
                         city_id: 1,
                         article_id: 2)

    Workshop.create( name: 'Vin sarbatorile',
                      city_id: 1)


#    99.times do |n|
#      name  = Faker::Name.name
#      email = "example-#{n+1}@railstutorial.org"
#      password  = "password"
#      User.create!(name: name,
#                   email: email,
#                   password: password,
#                   password_confirmation: password)

#    end

  end
end
