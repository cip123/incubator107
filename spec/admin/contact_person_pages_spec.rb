require 'spec_helper'
include Devise::TestHelpers


describe "Contact Person" do

  let!(:cluj_city) { FactoryGirl.create(:city, name: "Cluj" ) }
  let!(:bucharest_city) { FactoryGirl.create(:city, domain: :bucharest, name: "Bucuresti", email: "bucuresti@incubator107.com") }
  let!(:cluj_contact) { FactoryGirl.create(:contact_person, city: cluj_city, name: "cluj person" ) }
  let!(:bucharest_contact) { FactoryGirl.create(:contact_person, city: bucharest_city, name: "bucuresti person") }

  let(:login) { 
    fill_in "admin_user_email", :with => 'admin@incubator107.com'
    fill_in "admin_user_password" , :with => "password"
    click_button :Login
  }

  describe "configuration" do 

    let(:resource_class) { ContactPerson }
    let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
    let(:resource)       { all_resources[resource_class] }

    it "resource should be configured " do
      expect(ActiveAdmin.application.namespaces[:admin].resources["ContactPerson"]).not_to be_nil
      expect(resource.defined_actions).to  include(:create, :new, :update, :edit, :index, :show, :destroy)
    end

  end


  describe "pages" do

    let(:contact_person_nodes) { page.all("#index_table_contact_people > tbody > tr") }

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
        visit url_for_subdomain :cluj, "/admin/contact_people"
        login 
      end

      it "should display all the contact persons" do
        expect(contact_person_nodes[0]).to have_content("Bucuresti")
        expect(contact_person_nodes[1]).to have_content("Cluj")  
      end

      it "should order by id" do
        click_link('Id')

        expect(contact_person_nodes[1]).to have_content("Bucuresti")
        expect(contact_person_nodes[0]).to have_content("Cluj")  
      end

      it "should order by name" do
        click_link('Name')

        expect(contact_person_nodes[0]).to have_content("Cluj")  
        expect(contact_person_nodes[1]).to have_content("Bucuresti")
      end

      it "should order by title " do
        click_link('Title')

        expect(contact_person_nodes[0]).to have_content("Bucuresti")
        expect(contact_person_nodes[1]).to have_content("Cluj")  
      end

      it "should order by email" do
        click_link('Email')

        expect(contact_person_nodes[0]).to have_content(bucharest_contact.email)
        expect(contact_person_nodes[1]).to have_content(cluj_contact.email)  
      end

      it "should order by index" do
        click_link('Index')

        expect(contact_person_nodes[0]).to have_content(bucharest_contact.email)
        expect(contact_person_nodes[1]).to have_content(cluj_contact.email)  
      end



      it "should filter by city" do      
        select "Cluj", from: :q_city_id
        click_button "Filter"

        expect(contact_person_nodes.count).to eq(1)
        expect(contact_person_nodes[0]).to have_content("Cluj") 
      end
    
       it "should filter by name" do      
        fill_in :q_name, with: cluj_contact.name
        click_button "Filter"

        expect(contact_person_nodes.count).to eq(1)
        expect(contact_person_nodes[0]).to have_content("Cluj") 
      end

      it "should delete a contact person", js: true do
        alert_text = page.accept_confirm do
          within contact_person_nodes[0] do
            click_link "Delete"
          end
        end

        expect(ContactPerson.count).to eq(1)
      end

      it "should create a contact person", js: true do
        click_link "New Contact Person"
        fill_in :contact_person_name, with: "test name"
        fill_in :contact_person_email, with: "test@email.ro"
        fill_in :contact_person_phone, with: "test phone"
        fill_in :contact_person_title, with: "test title"
        fill_in :contact_person_about, with: "test about"
        fill_in :contact_person_team, with: "test team"
        fill_in :contact_person_index, with: 10
        select "Cluj", from: :contact_person_city_id

        click_button "Create Contact person" 

        # we make sure the page is loaded
        expect(page).to have_content("Contact Person Details")
        contact_person = ContactPerson.find(3)
        expect(contact_person.name).to eq("test name")
        expect(contact_person.email).to eq("test@email.ro")
        expect(contact_person.phone).to eq("test phone")
        expect(contact_person.title).to eq("test title")
        expect(contact_person.about).to eq("test about")
        expect(contact_person.team).to eq("test team")
        expect(contact_person.index).to eq(10)
        expect(contact_person.city).to eq(cluj_city)
     end

    end

    describe "view" do

      before do
        visit url_for_subdomain :cluj, "/admin/contact_people/1"
        login 
      end

      it "should contain all the elements" do      
        expect(page).to have_content(cluj_contact.name)
        expect(page).to have_content(cluj_contact.email)
        expect(page).to have_content(cluj_contact.phone)
        expect(page).to have_content(cluj_contact.title)
        expect(page).to have_content(cluj_contact.about)
        expect(page).to have_content(cluj_contact.team)
        expect(page).to have_content(cluj_contact.index)
        expect(page).to have_content(cluj_contact.index)
        # TODO attached file
      end

      it "should update the contact person", js: true do      
        click_link "Edit Contact Person"

        fill_in :contact_person_name, with: "test name"
        fill_in :contact_person_email, with: "test@email.ro"
        fill_in :contact_person_phone, with: "test phone"
        fill_in :contact_person_title, with: "test title"
        fill_in :contact_person_about, with: "test about"
        fill_in :contact_person_team, with: "test team"
        fill_in :contact_person_index, with: 10
        select "Bucuresti", from: :contact_person_city_id

        click_button "Update Contact person" 

        # we make sure the page is loaded
        expect(page).to have_content("Contact Person Details")
        contact_person = ContactPerson.find(1)
        expect(contact_person.name).to eq("test name")
        expect(contact_person.email).to eq("test@email.ro")
        expect(contact_person.phone).to eq("test phone")
        expect(contact_person.title).to eq("test title")
        expect(contact_person.about).to eq("test about")
        expect(contact_person.team).to eq("test team")
        expect(contact_person.index).to eq(10)
        expect(contact_person.city).to eq(bucharest_city)
     end

    end

  end

end
