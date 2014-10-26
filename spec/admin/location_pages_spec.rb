require 'spec_helper'
include Devise::TestHelpers


describe "Location" do

  let!(:cluj_city) { FactoryGirl.create(:city, name: "Cluj") }
  let!(:bucharest_city) { FactoryGirl.create(:city, domain: :bucharest, name: "Bucuresti", email: "bucuresti@incubator107.com") }


  describe "configuration" do 

    let(:resource_class) { Location }
    let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
    let(:resource)       { all_resources[resource_class] }

    it "resource should be configured " do
      expect(ActiveAdmin.application.namespaces[:admin].resources["Location"]).not_to be_nil
      expect(resource.defined_actions).to  include(:create, :new, :update, :edit, :index, :show, :destroy)
    end

  end


  describe "pages" do

    let(:location_nodes) { page.all("#index_table_locations > tbody > tr") }
    let(:login) { 
      fill_in "admin_user_email", :with => 'admin@incubator107.com'
      fill_in "admin_user_password" , :with => "password"
      click_button :Login
    }

    before do
      AdminUser.create!(email: 'admin@incubator107.com', password: "password", password_confirmation: "password") 
      FactoryGirl.create(:location, name: "Location 1 Cluj", city: cluj_city, description: "descriere <b>1</b>", address: "address 1")
      FactoryGirl.create(:location, name: "Location 1 Bucuresti", city: bucharest_city, description: "descriere <b>2</b>", address: "address 2")
    end


    describe "index" do

      before do
        visit url_for_subdomain :cluj, "/admin/locations"
        login 
      end

      it "should display all the locations" do
        expect(location_nodes[0]).to have_content("Location 1 Bucuresti")
        expect(location_nodes[1]).to have_content("Location 1 Cluj")  
      end

      it "should order by id" do
        click_link('Id')

        expect(location_nodes[1]).to have_content("Location 1 Bucuresti")
        expect(location_nodes[0]).to have_content("Location 1 Cluj")  
      end

      it "should order by name" do
        click_link('Name')

        expect(location_nodes[1]).to have_content("Location 1 Bucuresti")
        expect(location_nodes[0]).to have_content("Location 1 Cluj")  
      end

      it "should order by address" do
        click_link('Address')

        expect(location_nodes[0]).to have_content("Location 1 Bucuresti")
        expect(location_nodes[1]).to have_content("Location 1 Cluj")  
      end

      it "should filter by cities" do      
        select "Cluj", :from => "q_city_id"
        click_button "Filter"

        expect(location_nodes.count).to eq(1)
        expect(location_nodes[0]).to have_content("Location 1 Cluj") 
      end

      it "should filter by name" do      
        fill_in :q_translations_name, with: "Cluj"
        click_button "Filter"

        expect(location_nodes.count).to eq(1)
        expect(location_nodes[0]).to have_content("Location 1 Cluj") 
      end

      it "should delete a location", js: true do
        alert_text = page.accept_confirm do
          within location_nodes[0] do
            click_link "Delete"
          end
        end

        expect(Location.count).to eq(1)
      end

      it "should create a location", js: true do
        click_link "New Location"
        fill_in "location_name", with: "test"
        fill_in "location_address", with: "test address"
        select "Cluj", :from => "location_city_id"
        fill_in_tinymce :location_description, with: "test <b>important!</b>"

        click_button "Create Location" 
        
        # we make sure the page is loaded
        expect(page).to have_content("Location Details")
        location = Location.find(3)
        expect(location.city_id).to eq(1)
        expect(location.name).to eq("test")
        expect(location.address).to eq("test address")
        expect(location.description).to eq("<p>test &lt;b&gt;important!&lt;/b&gt;</p>")
      end
    end


    describe "view" do

      before do
        visit url_for_subdomain :cluj, "/admin/locations/1"
        login 
      end

      it "should contain all the elements" do      
        expect(page).to have_content('Location 1 Cluj')
        expect(page).to have_content('descriere 1')
        expect(page).to have_content('address 1')
      end

      it "should update the location", js: true do      
        click_link "Edit Location"
        fill_in "location_name", with: "test"
        fill_in "location_address", with: "test address"
        select "Bucuresti", :from => "location_city_id"
        fill_in_tinymce :location_description, with: "test <b>important!</b>"

        click_button "Update Location" 
         
        # we make sure the page is loaded
        expect(page).to have_content("Location Details")
        location = Location.find(1)
        expect(location.city_id).to eq(2)
        expect(location.name).to eq("test")
        expect(location.address).to eq("test address")
        expect(location.description).to eq("<p>test &lt;b&gt;important!&lt;/b&gt;</p>")
      end
    end

  end
end
