require 'spec_helper'

describe "Event" do

  let!(:cluj_city) { FactoryGirl.create(:city, name: "Cluj") }

  let!(:workshop) { FactoryGirl.create(:workshop, city: cluj_city) }

  let!(:location_a) { FactoryGirl.create(:location, name: "Location A")}
  let!(:location_b) { FactoryGirl.create(:location, name: "Location B")}

  let!(:event_a) { FactoryGirl.create(:event, workshop: workshop, start_date: DateTime.parse("2014-10-01"), location: location_a) }
  let!(:event_b) { FactoryGirl.create(:event, workshop: workshop, start_date: DateTime.parse("2014-11-02"), location: location_b) }

  describe "configuration" do 

    let(:resource_class) { News }
    let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
    let(:resource)       { all_resources[resource_class] }

    it "resource should be configured" do
      expect(ActiveAdmin.application.namespaces[:admin].resources["Event"]).not_to be_nil
      expect(resource.defined_actions).to  include(:create, :new, :update, :edit, :index, :show, :destroy)
    end

  end


  describe "pages" do

    let(:event_nodes) { page.all("#index_table_events > tbody > tr") }
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
        visit url_for_subdomain :cluj, "/admin/workshops/1/events"
        login 
      end

      it "should display all the news" do
        expect(event_nodes[0]).to have_content("2014-11-02")
        expect(event_nodes[1]).to have_content("2014-10-01")  
      end

      it "should order by id" do
        click_link('Id')

        expect(event_nodes[0]).to have_content("2014-10-01")  
        expect(event_nodes[1]).to have_content("2014-11-02")
      end

      it "should order by start date" do
        click_link('Start Date')

        expect(event_nodes[0]).to have_content("2014-11-02")
        expect(event_nodes[1]).to have_content("2014-10-01")  
      end

      it "should order by location" do
        click_link('Location')

        expect(event_nodes[0]).to have_content("Location B")  
        expect(event_nodes[1]).to have_content("Location A")
      end

      it "should delete an event", js: true do
        alert_text = page.accept_confirm do
          within event_nodes[0] do
            click_link "Delete"
          end
        end

        expect(Event.count).to eq(1)
      end

      it "should create an event", js: true do
        click_link "New Event"
        select "Location A", from: :event_location_id
        fill_in "event[start_date_date]", with: Date.today
        fill_in :event_duration, with: "100"
        click_button "Create Event" 

        # we make sure the page is loaded
        expect(page).to have_content("Event Details")
        event = Event.find(3)

        expect(event.location).to eq(location_a)
        expect(event.start_date).to eq(Date.today)
        expect(event.duration).to eq(100)
      end
    end


    describe "view" do

      before do
        visit url_for_subdomain :cluj, "/admin/workshops/1/events/1"
        login 
      end

      it "should contain all the elements" do      
        expect(page).to have_content('2014-10-01')
        expect(page).to have_content('Location A')
        expect(page).to have_content('120')
      end

      it "should update the event", js: true do      
        click_link "Edit Event"
        select "Location B", from: :event_location_id
        fill_in "event[start_date_date]", with: Date.today
        fill_in :event_duration, with: "100"
        click_button "Update Event" 

        # we make sure the page is loaded
        expect(page).to have_content("Event Details")
        event = Event.find(1)
        expect(event.location).to eq(location_b)
        expect(event.start_date).to eq(Date.today)
        expect(event.duration).to eq(100)
      end

    end

  end

end
