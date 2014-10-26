require 'spec_helper'
include Devise::TestHelpers


describe "WorkshopRequest" do

  let!(:cluj_city) { FactoryGirl.create(:city, name: "Cluj") }
  let!(:bucharest_city) { FactoryGirl.create(:city, domain: :bucharest, name: "Bucuresti", email: "bucuresti@incubator107.com") }
  let!(:workshop_cluj) { FactoryGirl.create(:workshop, name: "Workshop Cluj", city: cluj_city) }
  let!(:workshop_bucharest) { FactoryGirl.create(:workshop, name: "Workshop Bucuresti", city: bucharest_city) }

  let!(:person_cluj) { FactoryGirl.create(:person, name: "Persoana Cluj") }
  let!(:person_bucharest) { FactoryGirl.create(:person, name: "Persoana Bucuresti") }

  let(:request_nodes) { page.all("#index_table_workshop_requests > tbody > tr") }
  let(:login) { 
    fill_in "admin_user_email", :with => 'admin@incubator107.com'
    fill_in "admin_user_password" , :with => "password"
    click_button :Login
  }
  describe "configuration" do 

    let(:resource_class) { WorkshopRequest }
    let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
    let(:resource)       { all_resources[resource_class] }

    it "resource should be configured " do
      expect(ActiveAdmin.application.namespaces[:admin].resources["WorkshopRequest"]).not_to be_nil
      expect(resource.defined_actions).to  include(:create, :new, :update, :edit, :index, :show, :destroy)
    end

  end


  describe "pages" do

    before do
      AdminUser.create!(email: 'admin@incubator107.com', password: "password", password_confirmation: "password") 
      FactoryGirl.create(:workshop_request, workshop: workshop_cluj, reason: "vreau la cluj", person: person_cluj)
      FactoryGirl.create(:workshop_request, workshop: workshop_bucharest, reason: "vreau la bucuresti", person: person_bucharest) 
    end


    describe "index" do

      before do
        visit url_for_subdomain :cluj, "/admin/workshop_requests"
        login 
      end

      it "should display all the workshop requests" do
        expect(request_nodes[0]).to have_content("Workshop Bucuresti")
        expect(request_nodes[1]).to have_content("Workshop Cluj")  
      end

      it "should order by id" do
        click_link('Id')

        expect(request_nodes[1]).to have_content("Workshop Bucuresti")
        expect(request_nodes[0]).to have_content("Workshop Cluj")  
      end

      it "should order by person" do
        click_link('Person')

        expect(request_nodes[0]).to have_content("Persoana Bucuresti")
        expect(request_nodes[1]).to have_content("Persoana Cluj")  
      end

      it "should order by workshop" do
        click_link('Workshop')

        expect(request_nodes[0]).to have_content("Workshop Bucuresti")
        expect(request_nodes[1]).to have_content("Workshop Cluj")  
      end

      it "should filter by workshop" do      
        fill_in :q_workshop_translations_name, with: "Cluj"
        click_button "Filter"

        expect(request_nodes.count).to eq(1)
        expect(request_nodes[0]).to have_content("Persoana Cluj") 
      end

      it "should filter by person" do      
        fill_in :q_person_name, with: "Cluj"
        click_button "Filter"

        expect(request_nodes.count).to eq(1)
        expect(request_nodes[0]).to have_content("Persoana Cluj") 
      end

      it "should delete an article", js: true do
        alert_text = page.accept_confirm do
          within request_nodes[0] do
            click_link "Delete"
          end
        end

        expect(WorkshopRequest.count).to eq(1)
      end

      it "should create a workshop request" do
        click_link "New Workshop Request"
        select person_cluj.email, from: "workshop_request_person_id"
        select "Workshop Cluj", from: "workshop_request_workshop_id"
        fill_in :workshop_request_reason, with: "Pace pentru fratii mei iubire totdeauna"

        click_button "Create Workshop request" 

        # we make sure the page is loaded
        expect(page).to have_content("Workshop Request Details")
        workshop_request = WorkshopRequest.find(3)
        expect(workshop_request.workshop_id).to eq(1)
        expect(workshop_request.person_id).to eq(1)
        expect(workshop_request.reason).to eq("Pace pentru fratii mei iubire totdeauna")
      end

    end

    describe "view" do

      before do
        visit url_for_subdomain :cluj, "/admin/workshop_requests/1"
        login 
      end

      it "should contain all the elements" do      
        expect(page).to have_content('Workshop Cluj')
        expect(page).to have_content('vreau la cluj')
        expect(page).to have_content('Persoana Cluj')
      end

      it "should update the workshop_request" do      
        click_link "Edit Workshop Request"
        select person_bucharest.email, from: "workshop_request_person_id"
        select workshop_bucharest.name, from: "workshop_request_workshop_id"
        fill_in :workshop_request_reason, with: "Lupta Dorinele!"

        click_button "Update Workshop request" 

        # we make sure the page is loaded
        expect(page).to have_content("Workshop Request Details")
        workshop_request = WorkshopRequest.find(1)
        expect(workshop_request.person_id).to eq(2)
        expect(workshop_request.workshop_id).to eq(2)
        expect(workshop_request.reason).to eq("Lupta Dorinele!")
      end

    end
  end
end
