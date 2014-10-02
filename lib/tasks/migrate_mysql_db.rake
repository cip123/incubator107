#! /usr/bin/env ruby
#
# original file src/test/examples/testlibpq.c
# 



namespace :mysql do

  task :migrate_workshops => :environment do | t, args| 

    client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => 'root', :database => 'incuba43_old')
    results = client.query("select * from model_atelier limit 1000")

    facebook_albums = facebook_albums();

    results.each do |row|
    # conveniently, row is a hash
    # the keys are the fields, as you'd expect
    # the values are pre-built ruby primitives mapped from their corresponding field types in MySQL
    # Here's an otter: http://farm1.static.flickr.com/130/398077070_b8795d0ef3_b.jpg
      create_workshop row
    end
  end



  task :create_cities => :environment do | t, args| 

    City.create!(
      name: "Braşov", 
      domain: "brasov", 
      email: "brasov@incubator107.com", 
      facebook_page_id: "402491703139412", 
      google_analytics_code: "UA-9862367-4",
      default_donation: %{
                  Donaţia ta ajută incubator107 să supravieţuiască și ne încurajează meşterul. Sugerăm o donație de 10 lei pentru întreg atelierul. <br/>
                  Dacă nu vă puteți permite, nu stați departe, ne puteți ajuta în alte feluri: să promovăm în companii Programul de descoperire a pasiunilor sau să atragem sponsorizări
                }
    )

    City.create!(
      name: "Bucureşti", 
      domain: "bucuresti", 
      email: "inscrieri@incubator107.com", 
      facebook_page_id: "193875377299310", 
      google_analytics_code: "UA-9862367-4",
      default_whereabouts: %{Atelierul se ţine în mansarda noastră din <b>str. Traian 107 (Zona Hala Traian)</b>, sector 2, Bucure&#537;ti. Dacă nu ştii deja, află cum să ajungi: <a href="http://bucuresti.incubator107.com/contact.html">http://bucuresti.incubator107.com/contact.html</a>.
                },
      default_donation: %{
                  Donaţia ta ajută incubator107 să supravieţuiască și ne încurajează meşterul. Sugerăm o donație de 30 lei pentru fiecare întâlnire și 20 lei pentru studenți și liceeni.<br/>
                  Dacă nu vă puteți permite, nu stați departe, ne puteți ajuta în alte feluri: să promovăm în companii Programul de descoperire a pasiunilor, să închiriem mansarda pentru alte traininguri sau evenimente, să atragem sponsorizări sau să umplem pur și simplu mansarda de bucurie - <a href="http://bucuresti.incubator107.com/contact.html">http://bucuresti.incubator107.com/colaborari.html</a>.
                }

    )
    
    City.create!(
      name: "Cluj", 
      domain: "cluj", 
      email: "cluj@incubator107.com", 
      facebook_page_id: "292528864155748", 
      google_analytics_code: "UA-9862367-4",
      default_donation: %{
                  Donaţia ta ajută incubator107 să supravieţuiască și ne încurajează meşterul. Sugerăm o donație de 10 lei pentru întreg atelierul. <br/>
                  Dacă nu vă puteți permite, nu stați departe, ne puteți ajuta în alte feluri: să promovăm în companii Programul de descoperire a pasiunilor sau să atragem sponsorizări
                }
    )
    
    City.create!(
      name: "Craiova", 
      domain: "craiova", 
      email: "craiova@incubator107.com", 
      facebook_page_id: "179957508880461", 
      google_analytics_code: "UA-9862367-4",
      default_donation: %{
                  Donaţia ta ajută incubator107 să supravieţuiască și ne încurajează meşterul. Sugerăm o donație de 10 lei pentru întreg atelierul. <br/>
                  Dacă nu vă puteți permite, nu stați departe, ne puteți ajuta în alte feluri: să promovăm în companii Programul de descoperire a pasiunilor sau să atragem sponsorizări
                }

    )
    
    City.create!(
      name: "Iaşi", 
      domain: "iasi", 
      email: "iasi@incubator107.com", 
      facebook_page_id: "289340687818461", 
      google_analytics_code: "UA-9862367-4",
      default_donation: %{
                  Donaţia ta ajută incubator107 să supravieţuiască și ne încurajează meşterul. Sugerăm o donație de 10 lei pentru întreg atelierul. <br/>
                  Dacă nu vă puteți permite, nu stați departe, ne puteți ajuta în alte feluri: să promovăm în companii Programul de descoperire a pasiunilor sau să atragem sponsorizări
                }

    )
    
    City.create!(
      name: "Oradea", 
      domain: "oradea", 
      email: "oradea@incubator107.com", 
      facebook_page_id: "387632674676960", 
      google_analytics_code: "UA-9862367-4",
      default_donation: %{
                  Donaţia ta ajută incubator107 să supravieţuiască și ne încurajează meşterul. Sugerăm o donație de 10 lei pentru întreg atelierul. <br/>
                  Dacă nu vă puteți permite, nu stați departe, ne puteți ajuta în alte feluri: să promovăm în companii Programul de descoperire a pasiunilor sau să atragem sponsorizări
                }
    )
    
    City.create!(
      name: "Sibiu", 
      domain: "sibiu", 
      email: "sibiu@incubator107.com", 
      facebook_page_id: "1438185616416563", 
      google_analytics_code: "UA-9862367-4",
      default_donation: %{
                  Donaţia ta ajută incubator107 să supravieţuiască și ne încurajează meşterul. Sugerăm o donație de 10 lei pentru întreg atelierul. <br/>
                  Dacă nu vă puteți permite, nu stați departe, ne puteți ajuta în alte feluri: să promovăm în companii Programul de descoperire a pasiunilor sau să atragem sponsorizări
                }
    )
    
    City.create!(
      name: "Timişoara", 
      domain: "timisoara", 
      email: "timisoara@incubator107.com", 
      facebook_page_id: "381867868538349", 
      google_analytics_code: "UA-9862367-4",
      default_donation: %{
                  Donaţia ta ajută incubator107 să supravieţuiască și ne încurajează meşterul. Sugerăm o donație de 10 lei pentru întreg atelierul. <br/>
                  Dacă nu vă puteți permite, nu stați departe, ne puteți ajuta în alte feluri: să promovăm în companii Programul de descoperire a pasiunilor sau să atragem sponsorizări
                }
    )

  end

  task :migrate_articles => :environment do | t, args| 
    client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => 'root', :database => 'incuba43_old')
    results = client.query("select * from model_article")

    results.each do |row|

      Article.create(title: row["Title"], content: row["Text"], published: row["display"])
    end

    ArticleLink.create( city: City.find_by_domain(:brasov), article: Article.find_by(title: "Ce e incubator107?"), alias: ArticleLink.aliases[:about])
    ArticleLink.create( city: City.find_by_domain(:brasov), article: Article.find_by(title: "Colaborari Brasov"), alias: ArticleLink.aliases[:collaboration])
    ArticleLink.create( city: City.find_by_domain(:brasov), article: Article.find_by(title: "Locul tau Brasov"), alias: ArticleLink.aliases[:your_place])
    ArticleLink.create( city: City.find_by_domain(:brasov), article: Article.find_by(title: "Prieteni"), alias: ArticleLink.aliases[:friends])
    ArticleLink.create( city: City.find_by_domain(:brasov), article: Article.find_by(title: "2% Brasov"), alias: ArticleLink.aliases[:two_percent])

    ArticleLink.create( city: City.find_by_domain(:bucuresti), article: Article.find_by(title: "Ce e incubator107?"), alias: ArticleLink.aliases[:about])
    ArticleLink.create( city: City.find_by_domain(:bucuresti), article: Article.find_by(title: "Colaborari Bucuresti"), alias: ArticleLink.aliases[:collaboration])
    ArticleLink.create( city: City.find_by_domain(:bucuresti), article: Article.find_by(title: "Locul tău Bucuresti"), alias: ArticleLink.aliases[:your_place])
    ArticleLink.create( city: City.find_by_domain(:bucuresti), article: Article.find_by(title: "Prieteni"), alias: ArticleLink.aliases[:friends])
    ArticleLink.create( city: City.find_by_domain(:bucuresti), article: Article.find_by(title: "2% Bucuresti"), alias: ArticleLink.aliases[:two_percent])

    ArticleLink.create( city: City.find_by_domain(:cluj), article: Article.find_by(title: "Ce e incubator107?"), alias: ArticleLink.aliases[:about])
    ArticleLink.create( city: City.find_by_domain(:cluj), article: Article.find_by(title: "Colaborari Cluj"), alias: ArticleLink.aliases[:collaboration])
    ArticleLink.create( city: City.find_by_domain(:cluj), article: Article.find_by(title: "Locul tau Cluj"), alias: ArticleLink.aliases[:your_place])
    ArticleLink.create( city: City.find_by_domain(:cluj), article: Article.find_by(title: "Prieteni"), alias: ArticleLink.aliases[:friends])
    ArticleLink.create( city: City.find_by_domain(:cluj), article: Article.find_by(title: "2% Cluj"), alias: ArticleLink.aliases[:two_percent])
      
    ArticleLink.create( city: City.find_by_domain(:craiova), article: Article.find_by(title: "Ce e incubator107?"), alias: ArticleLink.aliases[:about])
    ArticleLink.create( city: City.find_by_domain(:craiova), article: Article.find_by(title: "Colaborari Bucuresti"), alias: ArticleLink.aliases[:collaboration])
    ArticleLink.create( city: City.find_by_domain(:craiova), article: Article.find_by(title: "Locul tău Bucuresti"), alias: ArticleLink.aliases[:your_place])
    ArticleLink.create( city: City.find_by_domain(:craiova), article: Article.find_by(title: "Prieteni"), alias: ArticleLink.aliases[:friends])
    ArticleLink.create( city: City.find_by_domain(:craiova), article: Article.find_by(title: "2% Craiova"), alias: ArticleLink.aliases[:two_percent])

    ArticleLink.create( city: City.find_by_domain(:iasi), article: Article.find_by(title: "Ce e incubator107?"), alias: ArticleLink.aliases[:about])
    ArticleLink.create( city: City.find_by_domain(:iasi), article: Article.find_by(title: "Colaborari Iasi"), alias: ArticleLink.aliases[:collaboration])
    ArticleLink.create( city: City.find_by_domain(:iasi), article: Article.find_by(title: "Locul tau Iasi"), alias: ArticleLink.aliases[:your_place])
    ArticleLink.create( city: City.find_by_domain(:iasi), article: Article.find_by(title: "Prieteni"), alias: ArticleLink.aliases[:friends])
    ArticleLink.create( city: City.find_by_domain(:iasi), article: Article.find_by(title: "2% Iasi"), alias: ArticleLink.aliases[:two_percent])

    ArticleLink.create( city: City.find_by_domain(:oradea), article: Article.find_by(title: "Ce e incubator107?"), alias: ArticleLink.aliases[:about])
    ArticleLink.create( city: City.find_by_domain(:oradea), article: Article.find_by(title: "Colaborari Bucuresti"), alias: ArticleLink.aliases[:collaboration])
    ArticleLink.create( city: City.find_by_domain(:oradea), article: Article.find_by(title: "Locul tău în incubator107 Oradea"), alias: ArticleLink.aliases[:your_place])
    ArticleLink.create( city: City.find_by_domain(:oradea), article: Article.find_by(title: "Prieteni"), alias: ArticleLink.aliases[:friends])
    ArticleLink.create( city: City.find_by_domain(:oradea), article: Article.find_by(title: "2% Oradea"), alias: ArticleLink.aliases[:two_percent])

    ArticleLink.create( city: City.find_by_domain(:sibiu), article: Article.find_by(title: "Ce e incubator107?"), alias: ArticleLink.aliases[:about])
    ArticleLink.create( city: City.find_by_domain(:sibiu), article: Article.find_by(title: "Colaborari Bucuresti"), alias: ArticleLink.aliases[:collaboration])
    ArticleLink.create( city: City.find_by_domain(:sibiu), article: Article.find_by(title: "Locul tău Bucuresti"), alias: ArticleLink.aliases[:your_place])
    ArticleLink.create( city: City.find_by_domain(:sibiu), article: Article.find_by(title: "Prieteni"), alias: ArticleLink.aliases[:friends])
    ArticleLink.create( city: City.find_by_domain(:sibiu), article: Article.find_by(title: "2% Bucuresti"), alias: ArticleLink.aliases[:two_percent])
    
    ArticleLink.create( city: City.find_by_domain(:timisoara), article: Article.find_by(title: "Ce e incubator107?"), alias: ArticleLink.aliases[:about])
    ArticleLink.create( city: City.find_by_domain(:timisoara), article: Article.find_by(title: "Colaborari Timisoara"), alias: ArticleLink.aliases[:collaboration])
    ArticleLink.create( city: City.find_by_domain(:timisoara), article: Article.find_by(title: "Locul tau Timisoara"), alias: ArticleLink.aliases[:your_place])
    ArticleLink.create( city: City.find_by_domain(:timisoara), article: Article.find_by(title: "Prieteni"), alias: ArticleLink.aliases[:friends])
    ArticleLink.create( city: City.find_by_domain(:timisoara), article: Article.find_by(title: "2% Timisoara"), alias: ArticleLink.aliases[:two_percent])

  end


   task :migrate_workshops, [:workshop_id] => :environment do | t, args| 


    workshop_id = args["workshop_id"]
    puts workshop_id
    create_groups
    locations_map = migrate_and_cache_locations    


    client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => 'root', :database => 'incuba43_old')
    query = "select * from model_atelier"
    query += " WHERE id='#{workshop_id}'" if workshop_id
    
    results = client.query(query)
    
    fb_albums = facebook_albums()

    results.each do |row|
      
      puts row["Nume"]
      group = Group.find_by(name: row["Breasla"])     
      city = City.find_by_domain(row["Oras"].downcase) unless row["Oras"].nil? 
      release_date = row["release date"].nil? ? DateTime.new(2010,1,1) : row["release date"]
      city_default_whereabouts = city.nil? ? "" : city.default_whereabouts
      whereabouts = row["where"].nil? ? city_default_whereabouts : row["where"]

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


  def create_groups
    group_names = %w(Breasla\ Făuritorilor Breasla\ Călătorilor Breasla\ Hedoniștilor Breasla\ Vrăjitorilor 
      Breasla\ Mișcătorilor Breasla\ Glăsuitorilor Breasla\ Descoperitorilor Mentor\ în\ incubator
      Breasla\ Copiilor nocturna Breasla\ Virtualilor Breasla\ Culinarilor)

    group_names.each do |group_name|
      Group.create name: group_name
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
    @graph = Koala::Facebook::API.new()    
    @albums = @graph.api("193875377299310/albums?limit=1000&fields=name,id")["data"]
    puts @albums
    @albums.each do |album|
      result[album["name"]] = album["id"]
    end

    return result
  end




  def create_workshop( params ) 
    workshop = Workshop.new
    workshop.name = params["Nume"]

    workshop.save
  end


end 
