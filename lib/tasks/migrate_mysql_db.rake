#! /usr/bin/env ruby
#
# original file src/test/examples/testlibpq.c
# 



namespace :mysql do

  task :migrate_workshops => :environment do | t, args| 

    client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => 'root', :database => 'incubator_old')
    results = client.query("select * from model_atelier limit 1")

    results.each do |row|
    # conveniently, row is a hash
    # the keys are the fields, as you'd expect
    # the values are pre-built ruby primitives mapped from their corresponding field types in MySQL
    # Here's an otter: http://farm1.static.flickr.com/130/398077070_b8795d0ef3_b.jpg
      create_workshop row
    end
  end



  task :create_cities => :environment do | t, args| 

    City.create!(name: "Braşov", domain: "brasov", email: "brasov@incubator107.com", facebook_page_id: "402491703139412", google_analytics_code: "UA-9862367-4")
    City.create!(name: "Bucureşti", domain: "bucuresti", email: "inscrieri@incubator107.com", facebook_page_id: "193875377299310", google_analytics_code: "UA-9862367-4")
    City.create!(name: "Cluj", domain: "cluj", email: "cluj@incubator107.com", facebook_page_id: "292528864155748", google_analytics_code: "UA-9862367-4")
    City.create!(name: "Craiova", domain: "craiova", email: "craiova@incubator107.com", facebook_page_id: "179957508880461", google_analytics_code: "UA-9862367-4")
    City.create!(name: "Iaşi", domain: "iasi", email: "iasi@incubator107.com", facebook_page_id: "289340687818461", google_analytics_code: "UA-9862367-4")
    City.create!(name: "Oradea", domain: "oradea", email: "oradea@incubator107.com", facebook_page_id: "387632674676960", google_analytics_code: "UA-9862367-4")
    City.create!(name: "Sibiu", domain: "sibiu", email: "sibiu@incubator107.com", facebook_page_id: "1438185616416563", google_analytics_code: "UA-9862367-4")
    City.create!(name: "Timişoara", domain: "timisoara", email: "timisoara@incubator107.com", facebook_page_id: "381867868538349", google_analytics_code: "UA-9862367-4")

  end

  task :migrate_articles => :environment do | t, args| 
    client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => 'root', :database => 'incubator_old')
    results = client.query("select * from model_article")

    results.each do |row|

      Article.create(title: row["Title"], content: row["Text"], published: row["display"])
    end

    ArticleLink.create( city: City.find_by_domain(:brasov), article: Article.find_by(title: "Ce e incubator107?"), alias: ArticleLink.aliases[:about])
    ArticleLink.create( city: City.find_by_domain(:brasov), article: Article.find_by(title: "Colaborari Brasov"), alias: ArticleLink.aliases[:collaboration])
    ArticleLink.create( city: City.find_by_domain(:brasov), article: Article.find_by(title: "Locul tău Brasov"), alias: ArticleLink.aliases[:your_place])
    ArticleLink.create( city: City.find_by_domain(:brasov), article: Article.find_by(title: "Prieteni"), alias: ArticleLink.aliases[:friends])
    ArticleLink.create( city: City.find_by_domain(:brasov), article: Article.find_by(title: "2% Brasov"), alias: ArticleLink.aliases[:two_percent])

    ArticleLink.create( city: City.find_by_domain(:bucuresti), article: Article.find_by(title: "Ce e incubator107?"), alias: ArticleLink.aliases[:about])
    ArticleLink.create( city: City.find_by_domain(:bucuresti), article: Article.find_by(title: "Colaborari Bucuresti"), alias: ArticleLink.aliases[:collaboration])
    ArticleLink.create( city: City.find_by_domain(:bucuresti), article: Article.find_by(title: "Locul tău Bucuresti"), alias: ArticleLink.aliases[:your_place])
    ArticleLink.create( city: City.find_by_domain(:bucuresti), article: Article.find_by(title: "Prieteni"), alias: ArticleLink.aliases[:friends])
    ArticleLink.create( city: City.find_by_domain(:bucuresti), article: Article.find_by(title: "2% Bucuresti"), alias: ArticleLink.aliases[:two_percent])

    ArticleLink.create( city: City.find_by_domain(:cluj), article: Article.find_by(title: "Ce e incubator107?"), alias: ArticleLink.aliases[:about])
    ArticleLink.create( city: City.find_by_domain(:cluj), article: Article.find_by(title: "Colaborari Cluj"), alias: ArticleLink.aliases[:collaboration])
    ArticleLink.create( city: City.find_by_domain(:cluj), article: Article.find_by(title: "Locul tău Cluj"), alias: ArticleLink.aliases[:your_place])
    ArticleLink.create( city: City.find_by_domain(:cluj), article: Article.find_by(title: "Prieteni"), alias: ArticleLink.aliases[:friends])
    ArticleLink.create( city: City.find_by_domain(:cluj), article: Article.find_by(title: "2% Cluj"), alias: ArticleLink.aliases[:two_percent])
      
    ArticleLink.create( city: City.find_by_domain(:craiova), article: Article.find_by(title: "Ce e incubator107?"), alias: ArticleLink.aliases[:about])
    ArticleLink.create( city: City.find_by_domain(:craiova), article: Article.find_by(title: "Colaborari Bucuresti"), alias: ArticleLink.aliases[:collaboration])
    ArticleLink.create( city: City.find_by_domain(:craiova), article: Article.find_by(title: "Locul tău Bucuresti"), alias: ArticleLink.aliases[:your_place])
    ArticleLink.create( city: City.find_by_domain(:craiova), article: Article.find_by(title: "Prieteni"), alias: ArticleLink.aliases[:friends])
    ArticleLink.create( city: City.find_by_domain(:craiova), article: Article.find_by(title: "2% Craiova"), alias: ArticleLink.aliases[:two_percent])

    ArticleLink.create( city: City.find_by_domain(:iasi), article: Article.find_by(title: "Ce e incubator107?"), alias: ArticleLink.aliases[:about])
    ArticleLink.create( city: City.find_by_domain(:iasi), article: Article.find_by(title: "Colaborari Iasi"), alias: ArticleLink.aliases[:collaboration])
    ArticleLink.create( city: City.find_by_domain(:iasi), article: Article.find_by(title: "Locul tău Iasi"), alias: ArticleLink.aliases[:your_place])
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
    ArticleLink.create( city: City.find_by_domain(:timisoara), article: Article.find_by(title: "Locul tău Timisoara"), alias: ArticleLink.aliases[:your_place])
    ArticleLink.create( city: City.find_by_domain(:timisoara), article: Article.find_by(title: "Prieteni"), alias: ArticleLink.aliases[:friends])
    ArticleLink.create( city: City.find_by_domain(:timisoara), article: Article.find_by(title: "2% Timisoara"), alias: ArticleLink.aliases[:two_percent])

  end


   task :migrate_workshops => :environment do | t, args| 

    group_names = %w(Breasla\ Făuritorilor Breasla\ Călătorilor Breasla\ Hedoniștilor Breasla\ Vrăjitorilor 
      Breasla\ Mișcătorilor Breasla\ Glăsuitorilor Breasla\ Descoperitorilor Mentor\ în\ incubator
      Breasla\ Copiilor nocturna Breasla\ Virtualilor Breasla\ Culinarilor)

    group_names.each do |group_name|
      Group.create name: group_name
    end      

     p Group.first.name
     p Group.find_by(name: "Breasla Făuritorilor")

    client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => 'root', :database => 'incubator_old')
    results = client.query("select * from model_atelier limit 1")

    results.each do |row|
      p row.inspect
      Workshop.create(
        name: row["Nume"], 
        description: row["Ce?"], 
        with_whom: row["Cu cine?"], 
        bring_along: row["Cu ce?"], 
        whereabouts: row["where"], 
        group_id: Group.find_by(name: row["Breasla"]).id, 
        notification: row["enable_reminder"],
        city_id: City.find_by_domain(row["Oras"].downcase).id
      )
    end
  end


  def create_workshop( params ) 
    workshop = Workshop.new
    workshop.name = params["Nume"]

    workshop.save
  end


end 
