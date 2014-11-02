require 'spec_helper'
require 'rack/test'

describe "News" do

  let!(:cluj_city) { FactoryGirl.create(:city, name: "Cluj") }
  let!(:bucharest_city) { FactoryGirl.create(:city, domain: :bucharest, name: "Bucuresti", email: "bucuresti@incubator107.com") }


  describe "configuration" do 

    let(:resource_class) { News }
    let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
    let(:resource)       { all_resources[resource_class] }

    it "resource should be configured" do
      expect(ActiveAdmin.application.namespaces[:admin].resources["News"]).not_to be_nil
      expect(resource.defined_actions).to  include(:create, :new, :update, :edit, :index, :show, :destroy)
    end

  end


  describe "pages" do

    let(:news_nodes) { page.all("#index_table_news > tbody > tr") }
    let(:login) { 
      fill_in "admin_user_email", :with => 'admin@incubator107.com'
      fill_in "admin_user_password" , :with => "password"
      click_button :Login
    }

    before do
      AdminUser.create!(email: 'admin@incubator107.com', password: "password", password_confirmation: "password") 
      FactoryGirl.create(:news, title: "News 1 Cluj", city: cluj_city, published: true)
      FactoryGirl.create(:news, title: "News 1 Bucharest", city: bucharest_city, published: false)
    end


    describe "index" do

      before do
        visit url_for_subdomain :cluj, "/admin/news"
        login 
      end

      it "should display all the news" do
        expect(news_nodes[0]).to have_content("News 1 Bucharest")
        expect(news_nodes[1]).to have_content("News 1 Cluj")  
      end

      it "should order by id" do
        click_link('Id')

        expect(news_nodes[1]).to have_content("News 1 Bucharest")
        expect(news_nodes[0]).to have_content("News 1 Cluj")  
      end

      it "should order by title" do
        click_link('Title')

        expect(news_nodes[1]).to have_content("News 1 Bucharest")
        expect(news_nodes[0]).to have_content("News 1 Cluj")  
      end


      it "should filter by cities" do      
        select "Cluj", :from => "q_city_id"
        click_button "Filter"

        expect(news_nodes.count).to eq(1)
        expect(news_nodes[0]).to have_content("News 1 Cluj") 
      end

      it "should filter by title" do      
        fill_in :q_translations_title, with: "Cluj"
        click_button "Filter"

        expect(news_nodes.count).to eq(1)
        expect(news_nodes[0]).to have_content("News 1 Cluj") 
      end

      it "should filter by published" do      
        select "Cluj", :from => "q_city_id"
        click_button "Filter"

        expect(news_nodes.count).to eq(1)
        expect(news_nodes[0]).to have_content("News 1 Cluj") 
      end

      it "should delete a news", js: true do
        alert_text = page.accept_confirm do
          within news_nodes[0] do
            click_link "Delete"
          end
        end

        expect(News.count).to eq(1)
      end

      it "should create some news", js: true do
        click_link "New News"
        fill_in "news_title", with: "test"
        select "Cluj", :from => "news_city_id"
        fill_in :news_release_date, with: Date.today
        choose "news_published_true"
        fill_in_tinymce :news_content, with: "test <b>important!</b>"
        attach_file :news_image, Rails.root.join('spec', 'photos', 'test.jpg')
        click_button "Create News" 
        # we make sure the page is loaded
        expect(page).to have_content("News Details")
        news = News.find(3)
        expect(news.city_id).to eq(1)
        expect(news.title).to eq("test")
        expect(news.content).to eq("<p>test &lt;b&gt;important!&lt;/b&gt;</p>")
        expect(news.published).to eq(true)
        expect(news.image_file_name).to eq("test.jpg")
      end
    end


    describe "view" do

      before do
        
        file = File.open(Rails.root.join('spec', 'photos', 'test.jpg')) 
        news = News.find(1) 
        news.image = file
        file.close
        news.save!

        visit url_for_subdomain :cluj, "/admin/news/1"
        login 
      end

      it "should contain all the elements" do      
        expect(page).to have_content('News 1 Cluj')
        expect(page).to have_content('breaking news')
        expect(page).to have_content('Published true')
        expect(page).to have_css('img[alt="Test"]')
      end

      it "should update the article", js: true do      
        click_link "Edit News"
        fill_in "news_title", with: "test"
        select "Bucuresti", :from => "news_city_id"
        choose "news_published_false"
        attach_file :news_image, Rails.root.join('spec', 'photos', 'test2.jpg')
        fill_in_tinymce :news_content, with: "test <b>important!</b>"

        click_button "Update News" 

        # we make sure the page is loaded
        expect(page).to have_content("News Details")
        news = News.find(1)
        expect(news.city_id).to eq(2)
        expect(news.title).to eq("test")
        expect(news.content).to eq("<p>test &lt;b&gt;important!&lt;/b&gt;</p>")
        expect(news.published).to eq(false)
        expect(news.image_file_name).to eq("test2.jpg")
      end
    end

  end

end
