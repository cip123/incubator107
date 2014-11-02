require 'spec_helper'
include Devise::TestHelpers


describe "City" do

  let!(:cluj_city) { FactoryGirl.create(:city, name: "Cluj" ) }
  let!(:bucharest_city) { FactoryGirl.create(:city, domain: :bucharest, name: "Bucuresti", email: "bucuresti@incubator107.com") }
  let!(:cluj_location) { FactoryGirl.create(:location, city: cluj_city ) }
  let!(:bucharest_location) { FactoryGirl.create(:location, city: bucharest_city ) }

  let(:login) { 
    fill_in "admin_user_email", :with => 'admin@incubator107.com'
    fill_in "admin_user_password" , :with => "password"
    click_button :Login
  }

  describe "configuration" do 

    let(:resource_class) { City }
    let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
    let(:resource)       { all_resources[resource_class] }

    it "resource should be configured " do
      expect(ActiveAdmin.application.namespaces[:admin].resources["City"]).not_to be_nil
      expect(resource.defined_actions).to  include(:create, :new, :update, :edit, :index, :show, :destroy)
    end

  end


  describe "pages" do

    let(:city_nodes) { page.all("#index_table_cities > tbody > tr") }

    let(:login) { 
      fill_in "admin_user_email", :with => 'admin@incubator107.com'
      fill_in "admin_user_password" , :with => "password"
      click_button :Login
    }

    before do 
      cluj_city.default_event_location = cluj_location 
      cluj_city.save
      AdminUser.create!(email: 'admin@incubator107.com', password: "password", password_confirmation: "password") 
    end

    describe "index" do

      before do
        visit url_for_subdomain :cluj, "/admin/cities"
        login 
      end

      it "should display all the cities" do
        expect(city_nodes[0]).to have_content("Bucuresti")
        expect(city_nodes[1]).to have_content("Cluj")  
      end

      it "should order by id" do
        click_link('Id')

        expect(city_nodes[1]).to have_content("Bucuresti")
        expect(city_nodes[0]).to have_content("Cluj")  
      end

      it "should order by name" do
        click_link('Name')

        expect(city_nodes[0]).to have_content("Cluj")  
        expect(city_nodes[1]).to have_content("Bucuresti")
      end

      it "should order by domain" do
        click_link('Domain')

        expect(city_nodes[0]).to have_content("cluj")
        expect(city_nodes[1]).to have_content("bucharest")  
      end

     it "should order by email" do
        click_link('Email')

        expect(city_nodes[0]).to have_content(cluj_city.email)  
        expect(city_nodes[1]).to have_content("bucuresti@incubator107.com")
      end


      it "should filter by name" do      
        fill_in :q_translations_name, with: "Cluj"
        click_button "Filter"

        expect(city_nodes.count).to eq(1)
        expect(city_nodes[0]).to have_content("Cluj") 
      end

      it "should filter by domain " do      
        fill_in :q_domain, with: cluj_city.domain
        click_button "Filter"

        expect(city_nodes.count).to eq(1)
        expect(city_nodes[0]).to have_content("Cluj") 
      end
     
      it "should delete a city", js: true do
        alert_text = page.accept_confirm do
          within city_nodes[0] do
            click_link "Delete"
          end
        end

        expect(City.count).to eq(1)
      end

      it "should create a city", js: true do
        click_link "New City"
        fill_in :city_name, with: "test name"
        fill_in :city_email, with: "test@email.ro"
        fill_in :city_domain, with: "test"
        fill_in :city_facebook_page_id, with: "facebook"
        select cluj_location.name, from: :city_default_event_location_id
        fill_in :city_google_analytics_code, with: "ga"
        fill_in :city_mailchimp_key, with: "mc"
        fill_in :city_mailchimp_newsletter_list_id, with: "nlid"
        fill_in :city_mailchimp_workshop_list_id, with: "wlid"
        fill_in :city_mailchimp_workshop_groups_id, with: 1000 
        fill_in_tinymce :city_default_donation, with: "test donation"
        fill_in_tinymce :city_default_whereabouts, with: "test whereabouts"
        choose "city_active_true"

        click_button "Create City" 

        # we make sure the page is loaded
        expect(page).to have_content("City Details")
        city = City.find(3)
        expect(city.name).to eq("test name")
        expect(city.email).to eq("test@email.ro")
        expect(city.active).to eq(true)
        expect(city.domain).to eq("test")
        expect(city.facebook_page_id).to eq("facebook")
        expect(city.default_event_location).to eq(cluj_location)
        expect(city.google_analytics_code).to eq("ga")
        expect(city.mailchimp_key).to eq("mc")
        expect(city.mailchimp_newsletter_list_id).to eq("nlid")
        expect(city.mailchimp_workshop_list_id).to eq("wlid")
        expect(city.mailchimp_workshop_groups_id).to eq(1000)
        expect(city.default_donation).to eq("<p>test donation</p>")
        expect(city.default_whereabouts).to eq("<p>test whereabouts</p>")
      end

    end

    describe "view" do

      before do
        cluj_city.default_event_location = cluj_location 
        visit url_for_subdomain :cluj, "/admin/cities/1"
        login 
      end

      it "should contain all the elements" do      

        expect(page).to have_content(cluj_city.name)
        expect(page).to have_content(cluj_city.email)
        expect(page).to have_content(cluj_city.domain)
        expect(page).to have_content(cluj_city.facebook_page_id)
        expect(page).to have_content(cluj_city.google_analytics_code)
        expect(page).to have_content(cluj_city.default_event_location.name)
        expect(page).to have_content("donation")
        expect(page).to have_content("whereabouts")
        expect(page).to have_content(cluj_city.mailchimp_newsletter_list_id)
        expect(page).to have_content(cluj_city.mailchimp_workshop_list_id)
        expect(page).to have_content(cluj_city.mailchimp_workshop_groups_id)
      end

      it "should update the city", js: true do      
        click_link "Edit City"
        fill_in :city_name, with: "test name"
        fill_in :city_email, with: "test@email.ro"
        fill_in :city_domain, with: "test"
        fill_in :city_facebook_page_id, with: "facebook"
        select cluj_location.name, from: :city_default_event_location_id
        fill_in :city_google_analytics_code, with: "ga"
        choose "city_active_true"
        fill_in :city_mailchimp_key, with: "mc"
        fill_in :city_mailchimp_newsletter_list_id, with: "nlid"
        fill_in :city_mailchimp_workshop_list_id, with: "wlid"
        fill_in :city_mailchimp_workshop_groups_id, with: 1000 
        fill_in_tinymce :city_default_donation, with: "test donation"
        fill_in_tinymce :city_default_whereabouts, with: "test whereabouts"

        click_button "Update City" 
        # we make sure the page is loaded
        expect(page).to have_content("City Details")
        city = City.find(1)
        expect(city.name).to eq("test name")
        expect(city.active).to eq(true)
        expect(city.email).to eq("test@email.ro")
        expect(city.domain).to eq("test")
        expect(city.facebook_page_id).to eq("facebook")
        expect(city.default_event_location).to eq(cluj_location)
        expect(city.google_analytics_code).to eq("ga")
        expect(city.mailchimp_key).to eq("mc")
        expect(city.mailchimp_newsletter_list_id).to eq("nlid")
        expect(city.mailchimp_workshop_list_id).to eq("wlid")
        expect(city.mailchimp_workshop_groups_id).to eq(1000)
        expect(city.default_donation).to eq("<p>test donation</p>")
        expect(city.default_whereabouts).to eq("<p>test whereabouts</p>")
     end

    end

  end

end
