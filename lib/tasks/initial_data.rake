namespace :db do
  desc "Fill database with sample data"
  task init: :environment do

    City.destroy_all

    City.create!(
      name: "Braşov",
      active: true, 
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
      active: true, 
      domain: "bucuresti", 
      email: "inscrieri@incubator107.com", 
      facebook_page_id: "193875377299310", 
      default_event_location_id: 1,
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
      active: true, 
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
      active: true, 
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
      active: true, 
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
      active: true, 
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
      active: true, 
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
      active: true, 
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

    Group.destroy_all

    Group.create!(
        name: "Breasla Călătorilor",
        index: 1,
        active: true,
        image: File.open("tmp/breasla-calatorilor.png")
     )

    Group.create!(
        name: "Breasla Descoperitorilor",
        index: 2,
        active: true,
        image: File.open("tmp/breasla-descoperitorilor.png")
     )

   Group.create!(
        name: "Breasla Glăsuitorilor",
        index: 3,
        active: true,
        image: File.open("tmp/breasla-glasuitorilor.png")
     )

   Group.create!(
        name: "Breasla Făuritorilor",
        index: 4,
        active: true,
        image: File.open("tmp/breasla-fauritorilor.png")
     )

   Group.create(
        name: "Breasla Hedoniștilor",
        index: 5,
        active: true,
        image: File.open("tmp/breasla-hedonistilor.png")
     )

   Group.create(
        name: "Breasla Mișcătorilor",
        index: 6,
        active: true,
        image: File.open("tmp/breasla-miscatorilor.png")
     )

   Group.create(
        name: "Breasla Vrăjitorilor",
        index: 7,
        active: true,
        image: File.open("tmp/breasla-vrajitorilor.png")
     )

   Group.create(
        name: "Da-ți Demisia",
        index: 8,
        active: true,
        image: File.open("tmp/da-ti-demisia.png")
     )

  end

  task reset_pk_sequence: :environment do


    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end;

  end


end
