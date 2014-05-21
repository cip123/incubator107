namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    user = User.create!(name: "Ciprian",
                        email: "cip@trusca.net",
                        password: "foobar",
                        password_confirmation: "foobar",
                        admin: true 
                       )
    Article.create!(name: "Ce e incubator107?",
                    content: Faker::Lorem.paragraph,
                    user: user
                   )

    about_cluj = Article.create!(name: "Cine suntem",
                    content: Faker::Lorem.paragraph,
                    user: user
                   )

    City.create(name: 'Cluj',
                domain: 'cluj',
                articles: [about_cluj]
               )

    City.create(name: (I18n.t 'bucharest'),
                domain: 'bucuresti'
               )


    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)

    end

  end
end
