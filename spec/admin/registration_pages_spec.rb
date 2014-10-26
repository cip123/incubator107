require 'spec_helper'
include Devise::TestHelpers

describe "Registration" do

  let!(:cluj_city) { FactoryGirl.create(:city, name: "Cluj", default_whereabouts: "prin cluj" ) }
  let!(:bucharest_city) { FactoryGirl.create(:city, domain: :bucharest, name: "Bucuresti", email: "bucuresti@incubator107.com") }
  let!(:cluj_group) { FactoryGirl.create(:group) }
  let!(:bucharest_group) { FactoryGirl.create(:group) }
  let!(:cluj_workshop) { FactoryGirl.create(:workshop_with_events, name: "Workshop Cluj", city: cluj_city, published: false, group: cluj_group) }
  let!(:bucharest_workshop) { FactoryGirl.create(:workshop_with_events, name: "Workshop Bucuresti", city: bucharest_city, group: bucharest_group) }
  let!(:cluj_location) { FactoryGirl.create(:location) }
  let!(:bucharest_location) { FactoryGirl.create(:location) }
  let(:registration_nodes) { page.all("#index_table_registrations > tbody > tr") }
  let!(:cluj_person) { FactoryGirl.create(:person, name: "person c", city: cluj_city) }
  let!(:bucharest_person) { FactoryGirl.create(:person, name: "person b", city: bucharest_city) }

  let!(:bucharest_registration) { FactoryGirl.create(:registration, person: cluj_person, event: cluj_workshop.events[0])}
  let!(:cluj_registration) { FactoryGirl.create(:registration, person: bucharest_person, event: bucharest_workshop.events[2]) }

  let(:login) { 
    fill_in "admin_user_email", :with => 'admin@incubator107.com'
    fill_in "admin_user_password" , :with => "password"
    click_button :Login
  }

  describe "configuration" do 

    let(:resource_class) { Registration }
    let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
    let(:resource)       { all_resources[resource_class] }

    it "resource should be configured " do
      expect(ActiveAdmin.application.namespaces[:admin].resources["Registration"]).not_to be_nil
      expect(resource.defined_actions).to  include(:create, :new, :update, :edit, :index, :show, :destroy)
    end

  end


  describe "pages" do

    before do
      AdminUser.create!(email: 'admin@incubator107.com', password: "password", password_confirmation: "password") 
    end

    describe "index" do

      before do
        visit url_for_subdomain :cluj, "/admin/registrations"
        login 
      end

      it "should display all the registrations" do
        expect(registration_nodes[0]).to have_content("Workshop Bucuresti")
        expect(registration_nodes[1]).to have_content("Workshop Cluj")  
      end

      it "should order by id" do
        click_link('Id')

        expect(registration_nodes[1]).to have_content("Workshop Bucuresti")
        expect(registration_nodes[0]).to have_content("Workshop Cluj")  
      end

      it "should order by person" do
        click_link('Person')

        expect(registration_nodes[0]).to have_content("Workshop Cluj")  
        expect(registration_nodes[1]).to have_content("Workshop Bucuresti")
      end

      it "should order by event" do
        click_link('Event')

        expect(registration_nodes[0]).to have_content("Workshop Bucuresti")
        expect(registration_nodes[1]).to have_content("Workshop Cluj")  
      end

      it "should filter by workshop" do      
        fill_in :q_workshop_translations_name, with: "Cluj"
        click_button "Filter"

        expect(registration_nodes.count).to eq(1)
        expect(registration_nodes[0]).to have_content("Workshop Cluj") 
      end

      it "should filter by person" do      
        fill_in :q_person_name, with: cluj_person.name
        click_button "Filter"

        expect(registration_nodes.count).to eq(1)
        expect(registration_nodes[0]).to have_content("Workshop Cluj") 
      end

      it "should filter by city" do      
        select "Cluj", from: :q_workshop_city_id
        click_button "Filter"

        expect(registration_nodes.count).to eq(1)
        expect(registration_nodes[0]).to have_content("Workshop Cluj") 
      end
      
      it "should delete a registration", js: true do
        alert_text = page.accept_confirm do
          within registration_nodes[0] do
            click_link "Delete"
          end
        end

        expect(Registration.count).to eq(1)
      end

      it "should create a registration", js: true do
        click_link "New Registration"

        select cluj_person.email, from: :registration_person_id
        select "#{cluj_workshop.name} - #{cluj_workshop.events[0].description}", from: :registration_event_id
        fill_in :registration_reason, with: "test reason"

        click_button "Create Registration"

        # we make sure the page is loaded
        expect(page).to have_content("Registration Details")
        registration = Registration.find(3)

        expect(registration.person).to eq(cluj_person)
        expect(registration.workshop).to eq(cluj_workshop)
        expect(registration.reason).to eq("test reason")
     end

    end

    describe "view" do

      before do
        visit url_for_subdomain :cluj, "/admin/registrations/1"
        login 
      end

      it "should contain all the elements" do      
        expect(page).to have_content(cluj_person.name)
        expect(page).to have_content(cluj_workshop.name)
        expect(page).to have_content(cluj_workshop.events[0].name)
        expect(page).to have_content(cluj_registration.reason)
      end

      it "should update the registration", js: true do      
        click_link "Edit Registration"

        select bucharest_person.email, from: :registration_person_id
        select "#{bucharest_workshop.name} - #{bucharest_workshop.events[0].description}", from: :registration_event_id
        fill_in :registration_reason, with: "test reason"

        click_button "Update Registration"

        # we make sure the page is loaded
        expect(page).to have_content("Registration Details")
        registration = Registration.find(1)

        expect(registration.person).to eq(bucharest_person)
        expect(registration.workshop).to eq(bucharest_workshop)
        expect(registration.reason).to eq("test reason")
      end

    end

  end

end
