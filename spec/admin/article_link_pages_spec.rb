require 'spec_helper'
include Devise::TestHelpers


describe "Article link" do

  let!(:cluj_city) { FactoryGirl.create(:city, name: "Cluj") }
  let!(:bucharest_city) { FactoryGirl.create(:city, domain: :bucharest, name: "Bucuresti", email: "bucuresti@incubator107.com") }

  let!(:cluj_article) { FactoryGirl.create(:article, title: "About Cluj") }
  let!(:bucharest_article) { FactoryGirl.create(:article, title: "2% Bucharest") }

  let!(:cluj_article_link) { FactoryGirl.create(:article_link, alias: ArticleLink.aliases[:about], city: cluj_city, article: cluj_article) }
  let!(:bucharest_article_link) { FactoryGirl.create(:article_link, alias: ArticleLink.aliases[:two_percent], city: bucharest_city, article: bucharest_article) }

  describe "configuration" do 

    let(:resource_class) { ArticleLink }
    let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
    let(:resource)       { all_resources[resource_class] }

    it "resource should be configured " do
      expect(ActiveAdmin.application.namespaces[:admin].resources["ArticleLink"]).not_to be_nil
      expect(resource.defined_actions).to  include(:create, :new, :update, :edit, :index, :show, :destroy)
    end

  end


  describe "pages" do

    let(:link_nodes) { page.all("#index_table_article_links > tbody > tr") }
    let(:login) { 
      fill_in "admin_user_email", :with => 'admin@incubator107.com'
      fill_in "admin_user_password" , :with => "password"
      click_button :Login
    }

    before do
      AdminUser.create!(email: 'admin@incubator107.com', password: "password", password_confirmation: "password") 
    end


    describe "index" do

      before do
        visit url_for_subdomain :cluj, "/admin/article_links"
        login 
      end

      it "should display the correct article links" do
        expect(link_nodes[0]).to have_content("two_percent")  
        expect(link_nodes[1]).to have_content("about")
      end

      it "should order by id" do
        click_link('Id')

        expect(link_nodes[0]).to have_content("about")
        expect(link_nodes[1]).to have_content("two_percent")  
      end

      it "should order by alias" do
        click_link('Alias')

        expect(link_nodes[0]).to have_content("two_percent")  
        expect(link_nodes[1]).to have_content("about")
      end

      it "should order by article" do
        click_link('Article')

        expect(link_nodes[0]).to have_content("About Cluj")
        expect(link_nodes[1]).to have_content("2% Bucharest")  
      end

      it "should filter by cities" do      
        select "Cluj", :from => "q_city_id"
        click_button "Filter"

        expect(link_nodes.count).to eq(1)
        expect(link_nodes[0]).to have_content("About Cluj") 
      end

      it "should filter by alias" do      
        select "about", from: :q_alias
        click_button "Filter"

        expect(link_nodes.count).to eq(1)
        expect(link_nodes[0]).to have_content("About Cluj") 
      end

      it "should delete an article link", js: true do
        alert_text = page.accept_confirm do
          within link_nodes[0] do
            click_link "Delete"
          end
        end

        expect(ArticleLink.count).to eq(1)
      end

      it "should create an article link", js: true do
        click_link "New Article Link"
        select "friends", :from => "article_link_alias"
        select "Cluj", :from => "article_link_city_id"
        select "About Cluj", :from => "article_link_article_id"

        click_button "Create Article link"
        
        # we make sure the page is loaded
        expect(page).to have_content("Article Link Details")
        article_link = ArticleLink.find(3)
        expect(article_link.city).to eq(cluj_city)
        expect(article_link.article).to eq(cluj_article)
        expect(article_link.alias).to eq("friends")
      end

    end

    describe "view" do

      before do
        visit url_for_subdomain :cluj, "/admin/article_links/1"
        login 
      end

      it "should contain all the elements" do      
        expect(page).to have_content('Cluj')
        expect(page).to have_content('About Cluj')
        expect(page).to have_content('about')
      end

      it "should update the article link", js: true do      
        click_link "Edit Article Link"

        select "friends", :from => "article_link_alias"
        select "Bucuresti", :from => "article_link_city_id"
        select "2% Bucharest", :from => "article_link_article_id"

        click_button "Update Article link" 
         
        # we make sure the page is loaded
        expect(page).to have_content("Article Link Details")
        article_link = ArticleLink.find(1)
        expect(article_link.city).to eq(bucharest_city)
        expect(article_link.article).to eq(bucharest_article)
        expect(article_link.alias).to eq("friends")
      end
    end

  end
end
