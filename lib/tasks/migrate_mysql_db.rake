#! /usr/bin/env ruby
#
# original file src/test/examples/testlibpq.c
# 



namespace :mysql do

  task :create_admin_users => :environment do | t, args| 
    AdminUser.destroy_all
    AdminUser.create!(email: 'admin@incubator107.com', password: ENV['ADMIN_PASSWORD'], password_confirmation: ENV['ADMIN_PASSWORD']) if direction == :up
  end

  task :migrate_articles => :environment do | t, args| 
    client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => 'root', :database => 'incuba43_old')
    results = client.query("select * from model_article")

    Article.destroy_all

    results.each do |row|
      Article.create(title: row["Title"], content: row["Text"], published: row["display"])
    end

    article =  Article.find_by(title: "Locul tău Bucuresti") 
    article.title = "Locul tau"
    article.save!

    article = Article.find_by(title:"Colaborari Bucuresti")
    article.title = "Colaborari"
    article.alias = Article.aliases[:collaboration]
    article.save!

    article = Article.find_by(title:"2% Bucuresti")
    article.title = "2%"
    article.save!


    update_article title: "Ce e incubator107?", alias: :about, content: "about-us.html"
    update_article title: "Locul tau", alias: :your_place, content: "your-place.html"
    update_article title: "Colaborari", alias: :collaboration, content: "collaboration.html"
    update_article title: "2%", alias: :two_percent, content: "two-percent.html"

    update_article title: "Colaborari Brasov", alias: :collaboration, domain: :brasov
    update_article title: "Locul tau Brasov", alias: :your_place, domain: :brasov
    update_article title: "2% Brasov", alias: :two_percent, domain: :brasov

    update_article title: "Colaborari Cluj", alias: :collaboration, domain: :cluj
    update_article title: "Locul tau Cluj", alias: :your_place, domain: :cluj
    update_article title: "2% Cluj", alias: :two_percent, domain: :cluj

    update_article title: "2% Craiova", alias: :two_percent, domain: :craiova

    update_article title: "Colaborari Iasi", alias: :collaboration, domain: :iasi
    update_article title: "Locul tau Iasi", alias: :your_place, domain: :iasi
    update_article title: "2% Iasi", alias: :two_percent, domain: :iasi

    update_article title: "Locul tău în incubator107 Oradea", alias: :your_place, domain: :oradea
    update_article title: "2% Oradea", alias: :two_percent, domain: :oradea

    update_article title: "Colaborari Timisoara", alias: :collaboration, domain: :timisoara
    update_article title: "Locul tau Timisoara", alias: :your_place, domain: :timisoara
    update_article title: "2% Timisoara", alias: :two_percent, domain: :timisoara
      
  end

  def update_article params
    article = Article.find_by(title: params[:title])
    article.city = City.find_by_domain(params[:domain])
    article.alias = Article.aliases[params[:alias]]

   
    
    if params[:content] 
      content_path = "lib/tasks/articles/#{params[:content]}"
      file = File.open(content_path)
      article.content = file.read
      file.close    
    end

    article.save!
  end

   task :migrate_workshops, [:workshop_id] => :environment do | t, args| 

    workshop_id = args["workshop_id"]
    puts workshop_id
    locations_map = migrate_and_cache_locations    

    Workshop.destroy_all

    client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => 'root', :database => 'incuba43_old')
    query = "select * from model_atelier"
    query += " WHERE id='#{workshop_id}'" if workshop_id
    
    results = client.query(query)
    
    fb_albums = facebook_albums()
    
    results.each do |row|
      
      puts row["Nume"]
      puts fb_albums[row["Album"]]
      group = Group.find_by(name: row["Breasla"])     
      city = City.find_by_domain(row["Oras"].downcase) unless row["Oras"].nil? 
      release_date = row["release date"].nil? ? DateTime.new(2010,1,1) : row["release date"]
      city_default_whereabouts = city.nil? ? "" : city.default_whereabouts
      whereabouts = row["where"].nil? || row["where"].empty? ? city_default_whereabouts : row["where"]

      begin    
        workshop = Workshop.create!(
          name: row["Nume"], 
          description: row["Ce?"], 
          with_whom: row["Cu cine?"], 
          published: row["display"],
          bring_along: row["Cu ce?"], 
          whereabouts: whereabouts, 
          release_date: release_date,
          group_id: group.nil? ? nil: group.id, 
          should_send_notification: (row["enable_reminder"] == 1) ,
          requires_donation: (row["donation"] == 1),
          city_id: city.nil? ? nil : city.id,
          facebook_album_id: fb_albums[row["Album"]],
          donation: city.nil? ? "" : city.default_donation
        )
        
        meetings_id = row["Intalniri"]
        events = client.query("SELECT type_event.timestamp, type_event.id, type_event.duration, type_event.location, type_event.notification_text, type_list.list_id 
                          FROM type_event 
                          INNER JOIN type_list ON type_event.id = type_list.value
                          WHERE type_list.list_id = #{meetings_id}")  unless meetings_id.nil?

        events.each do |event|
          Event.create!(workshop_id: workshop.id, start_date: event["timestamp"], duration: event["duration"], location_id: locations_map[event["location"].to_i])
        end unless events.nil?
      rescue ActiveRecord::RecordInvalid => invalid
        puts row
        puts invalid.record.errors.inspect
      end
    end
  end

  task :migrate_people, [:arg1] => :environment  do | t, args| 

    Person.destroy_all
    Registration.destroy_all
    NewsletterSubscriber.destroy_all

    client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => 'root', :database => 'incuba43_old')
    people = client.query("select * from model_people")
    
    people.each do |row|
      Person.create(name: row["name"], email: row["mail"], phone: row["phone"], verified: row["verified"])
      last_comment = row["despre"]
      list_id = row["list"]

      lists = client.query("select * from type_list where list_id ='#{list_id}'")
      person = nil
      lists.each do |list|
        puts list
        if list["value"].starts_with?("newsletter_")
          domain = list["value"][11, list["value"].length - 1].downcase
          city = City.find_by_domain(domain)
          puts "could not resolve #{list}" if city.nil?
          person = Person.find_or_create_by(name: row["name"], email: row["mail"], phone: row["phone"], verified: row["approved"], city_id: city.id) unless city.nil?
          NewsletterSubscriber.find_or_create_by(city_id: city.id, email: row["mail"].downcase) unless city.nil?
        else 
          workshop = Workshop.find_by(workshop_translations: {name: list["value"]})
          if workshop
            person = Person.find_or_create_by(name: row["name"], email: row["mail"], phone: row["phone"], verified: row["approved"], city_id: workshop.city.id)
            puts "Could not resolve person: #{row}" unless person.valid?
            workshop.events.each do |event|
              Registration.create(event_id: event.id, person_id: person.id)
            end if person.valid?
          else
            puts "could not resolve List: #{list}" 
          end
        end

      end

      last_registration = person.registrations.last if person && person.valid?
      if last_registration 
        last_workshop = last_registration.event.workshop
        last_workshop.events.each do |event|
          registrations = Registration.where(person_id: person.id, event_id: event.id) 
          registrations.each do |registration|
            registration.reason = last_comment
            registration.save
          end
        end
      end
    end
  end

  task :migrate_news, [:arg1] => :environment  do | t, args| 

    News.destroy_all
    client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => 'root', :database => 'incuba43_old')
    news = client.query("select * from model_stiri")
    
    news.each do |row|
      release_date = row["release_date"]
      release_date = DateTime.new(2010,1,1) if release_date.blank?
      domain = row["Oras"].downcase
      city = City.find_by_domain(domain)
      image_path = row["Imagine"]
      begin

        news = News.create!(
          title: row["Titlu"], 
          content: row["Text"], 
          published: row["display"], 
          release_date: release_date, 
          city: city
        )

        unless image_path.nil? || image_path.empty?          
          image_path = image_path.gsub( /\s/, "\ ")          
          local_path = "/Users/cip/Projects/incubator/#{domain}/#{image_path}"
          puts local_path
          if File.exists?(local_path) && !File.directory?(local_path)
            file = File.open(local_path)
            news.image = file
            file.close
            news.save!
            puts "Success"
          else
            puts "#{image_path} is invalid"
          end
        end

      rescue ActiveRecord::RecordInvalid => invalid
        puts invalid.record.errors.inspect
      end
      
    end
  end



  task :migrate_partners, [:arg1] => :environment  do | t, args| 

    Partner.destroy_all
    client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => 'root', :database => 'incuba43_old')
    partners = client.query("select * from model_parteneri")
    
    partners.each do |row|
      domain = row["oras"].downcase
      city = City.find_by_domain(domain)
      image_path = row["Imagine"]
      category = (row["Categorie"])== "Prieteni" ? 0 : 1 
      begin

        partner = Partner.create!(
          name: row["Nume"], 
          description: row["Text"], 
          published: row["display"], 
          city: city,
          index: row["order"],
          category: category 
        )

        unless image_path.nil? || image_path.empty?          
          image_path = image_path.gsub( /\s/, "\ ")          
          local_path = "/Users/cip/Projects/incubator/#{domain}/#{image_path}"
          puts local_path
          if File.exists?(local_path) && !File.directory?(local_path)
            file = File.open(local_path)
            partner.image = file
            file.close
            partner.save!
            puts "Success"
          else
            puts "#{image_path} is invalid"
          end
        end

      rescue ActiveRecord::RecordInvalid => invalid
        puts invalid.record.errors.inspect
      end
      
    end
  end


  def migrate_and_cache_locations

    result  = {}    
    
    client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => 'root', :database => 'incuba43_old')
    # LOCATIONS:
    locations = client.query("select * from model_locations")
    locations.each do |l|
      location = Location.create(name: l["name"], url: l["link"], address: l["address"] )
      result[l["id"]] = location.id
    end

    return result
  end

  def facebook_albums

    result = {}
    url = "https://graph.facebook.com/v2.2/193875377299310/albums?fields=name,id&limit=50&access_token=#{ENV['FACEBOOK_APP_TOKEN']}"
    begin  
      response = JSON.parse(open(URI.encode(url)).read)
      url = response["paging"]["next"]
      @albums = response["data"]
      @albums.each do |album|
        result[album["name"]] = album["id"]
      end
    end until url.nil? 
  
    return result
  end



end 
