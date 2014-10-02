require 'rake'
require 'spec_helper'

describe 'mysql task' do

  before :all do
    Rake.application.rake_require "tasks/migrate_mysql_db"
    Rake::Task.define_task(:environment)
  end


  describe 'create cities' do

    let :run_rake_task do
      Rake::Task["mysql:create_cities"].reenable
      Rake.application.invoke_task "mysql:create_cities"
    end

    it "should create all cities" do
      run_rake_task
      puts City.all.inspect
      expect(City.all.count).to  eq(8)
    end
  end


  describe "migrate articles" do

    before do
      Rake::Task["mysql:create_cities"].reenable
      Rake.application.invoke_task "mysql:create_cities"
    end

    describe 'articles' do
      let :run_rake_task do
        Rake::Task["mysql:migrate_articles"].reenable
        Rake.application.invoke_task "mysql:migrate_articles"
      end

      it "should migrate articles" do      
        expect { run_rake_task }.to change { Article.all.count }
        check_links_for_city :brasov 
        check_links_for_city :bucuresti
        check_links_for_city :cluj
        check_links_for_city :craiova
        check_links_for_city :iasi
        check_links_for_city :oradea
        check_links_for_city :sibiu
        check_links_for_city :timisoara
      end

      def check_links_for_city (domain) 
        city_id = City.find_by_domain(domain).id
        expect(ArticleLink.exists?(alias: ArticleLink.aliases[:about], city_id: city_id)).to eq true
        expect(ArticleLink.exists?(alias: ArticleLink.aliases[:your_place], city_id: city_id)).to eq true
        expect(ArticleLink.exists?(alias: ArticleLink.aliases[:collaboration], city_id: city_id)).to eq true
        expect(ArticleLink.exists?(alias: ArticleLink.aliases[:friends], city_id: city_id)).to eq true
        expect(ArticleLink.exists?(alias: ArticleLink.aliases[:two_percent], city_id: city_id)).to eq true
      end
    end
  end


  describe "workshops" do

    before do
      Rake::Task["mysql:create_cities"].reenable
      Rake.application.invoke_task "mysql:create_cities"
    end

    describe 'workshops' do
      let :run_rake_task do
        Rake::Task["mysql:migrate_articles"].reenable
        Rake.application.invoke_task "mysql:migrate_workshops"
      end

      it "should migrate workshops" do
        expect { run_rake_task }.to change { Workshop.all.count }
        workshop = Workshop.all.first
        expect( workshop.facebook_album_id ).not_to be_empty
        events_count = workshop.events.count
        expect(events_count).to be > 0
      end

    end
  end

  describe "people" do

    let :run_rake_task do
      Rake::Task["mysql:migrate_articles"].reenable
      Rake.application.invoke_task "mysql:migrate_people[1]"
    end

    before do
      Rake::Task["mysql:create_cities"].reenable
      Rake.application.invoke_task "mysql:create_cities"
      Rake::Task["mysql:migrate_workshops"].reenable
      Rake.application.invoke_task "mysql:migrate_workshops[340]"
    end


    it "should migrate people" do
        expect { run_rake_task }.to change { Person.all.count }
        expect(Registration.all.count).to be > 0
        expect(NewsletterSubscriber.all.count).to be > 0
        expect(Person.all.take.registrations.last.reason).not_to be_nil
    end

    
  end

  describe "news" do

    let :run_rake_task do
      Rake::Task["mysql:migrate_news"].reenable
      Rake.application.invoke_task "mysql:migrate_news"
    end

    before do
      Rake::Task["mysql:create_cities"].reenable
      Rake.application.invoke_task "mysql:create_cities"
    end


    it "should migrate news" do
        expect { run_rake_task }.to change { News.all.count }
        # expect(Registration.all.count).to be > 0
        # expect(NewsletterSubscriber.all.count).to be > 0
        # expect(Person.all.take.registrations.last.reason).not_to be_nil
    end

    
  end


end
