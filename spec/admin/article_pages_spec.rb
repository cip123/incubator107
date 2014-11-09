require 'spec_helper'
include Devise::TestHelpers

describe "Article" do

  let!(:cluj_city) { FactoryGirl.create(:city, name: "Cluj") }
  let!(:bucharest_city) { FactoryGirl.create(:city, domain: :bucharest, name: "Bucuresti", email: "bucuresti@incubator107.com") }


  describe "configuration" do 

    let(:resource_class) { Article }
    let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
    let(:resource)       { all_resources[resource_class] }

    it "resource should be configured " do
      expect(ActiveAdmin.application.namespaces[:admin].resources["AdminUser"]).not_to be_nil
      expect(resource.defined_actions).to  include(:create, :new, :update, :edit, :index, :show, :destroy)
    end

  end


  describe "pages" do

    let(:article_nodes) { page.all("#index_table_articles > tbody > tr") }
    let(:login) { 
      fill_in "admin_user_email", :with => 'admin@incubator107.com'
      fill_in "admin_user_password" , :with => "password"
      click_button :Login
    }

    before do
      AdminUser.create!(email: 'admin@incubator107.com', password: "password", password_confirmation: "password") 
      FactoryGirl.create(:article, title: "Article 1 Cluj", city: cluj_city, published: true)
      FactoryGirl.create(:article, title: "Article 1 Bucharest", city: bucharest_city, published: false)
    end


    describe "index" do

      before do
        visit url_for_subdomain :cluj, "/admin/articles"
        login 
      end

      it "should display all the articles" do

        expect(article_nodes[0]).to have_content("Article 1 Bucharest")
        expect(article_nodes[1]).to have_content("Article 1 Cluj")  

      end

      it "should order by id" do

        click_link('Id')

        expect(article_nodes[1]).to have_content("Article 1 Bucharest")
        expect(article_nodes[0]).to have_content("Article 1 Cluj")  
      end

      it "should order by title" do
        click_link('Title')

        expect(article_nodes[1]).to have_content("Article 1 Bucharest")
        expect(article_nodes[0]).to have_content("Article 1 Cluj")  
      end


      it "should filter by cities" do      
        select "Cluj", :from => "q_city_id"
        click_button "Filter"

        expect(article_nodes.count).to eq(1)
        expect(article_nodes[0]).to have_content("Article 1 Cluj") 
      end

      it "should filter by title" do      
        fill_in :q_translations_title, with: "Cluj"
        click_button "Filter"

        expect(article_nodes.count).to eq(1)
        expect(article_nodes[0]).to have_content("Article 1 Cluj") 
      end

      it "should filter by published" do      
        select "Cluj", :from => "q_city_id"
        click_button "Filter"

        expect(article_nodes.count).to eq(1)
        expect(article_nodes[0]).to have_content("Article 1 Cluj") 
      end

      it "should delete an article", js: true do
        alert_text = page.accept_confirm do
          within article_nodes[0] do
            click_link "Delete"
          end
        end

        expect(Article.count).to eq(1)
      end

      it "should create an article", js: true do
        click_link "New Article"
        fill_in "article_title", with: "test"
        select "Cluj", :from => "article_city_id"
        choose "article_published_true"
        fill_in :article_content, with: "test <b>important!</b>"

        click_button "Create Article" 

        # we make sure the page is loaded
        expect(page).to have_content("Displaying all 3 Articles")
        article = Article.find(3)
        expect(article.city_id).to eq(1)
        expect(article.title).to eq("test")
        #expect(article.content).to eq("<p>test &lt;b&gt;important!&lt;/b&gt;</p>")
        expect(article.content).to eq("test <b>important!</b>")
        expect(article.published).to eq(true)
      end
    end


    describe "view" do

      before do
        visit url_for_subdomain :cluj, "/admin/articles/1"
        login 
      end

      it "should contain all the elements" do      
        expect(page).to have_content('Article 1 Cluj')
        expect(page).to have_content('Pace pentru fratii mei iubire totdeauna')
        expect(page).to have_content('Published true')
      end

      it "should update the article", js: true do      
        click_link "Edit Article"
        fill_in "article_title", with: "test"
        select "Bucuresti", :from => "article_city_id"
        choose "article_published_false"
        fill_in :article_content, with:  "test <b>important!</b>"

        click_button "Update Article" 
         
        # we make sure the page is loaded
        expect(page).to have_content("Displaying all 2 Articles")
        article = Article.find(1)
        expect(article.city_id).to eq(2)
        expect(article.title).to eq("test")
        expect(article.content).to eq("test <b>important!</b>")
        expect(article.published).to eq(false)
      end
    end

  end

end
