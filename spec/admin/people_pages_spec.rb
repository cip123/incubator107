require 'spec_helper'


describe "People" do

  let!(:cluj_city) { FactoryGirl.create(:city, name: "Cluj") }
  let!(:bucharest_city) { FactoryGirl.create(:city, domain: :bucharest, name: "Bucharest", email: "bucuresti@incubator107.com") }


  describe "configuration" do 

    let(:resource_class) { Person }
    let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
    let(:resource)       { all_resources[resource_class] }

    it "resource should be configured " do
      expect(ActiveAdmin.application.namespaces[:admin].resources["Person"]).not_to be_nil
      expect(resource.defined_actions).to  include(:create, :new, :update, :edit, :index, :show, :destroy)
    end

  end


  describe "pages" do

    let(:people_nodes) { page.all("#index_table_people > tbody > tr") }
    let(:login) { 
      fill_in "admin_user_email", :with => 'admin@incubator107.com'
      fill_in "admin_user_password" , :with => "password"
      click_button :Login
    }

    before do
      AdminUser.create!(email: 'admin@incubator107.com', password: "password", password_confirmation: "password") 
      FactoryGirl.create(:person, name: "Person 1 Cluj", city: cluj_city, email: "person@cluj.ro", phone: "07177777", verified: false)
      FactoryGirl.create(:person, name: "Person 1 Bucharest", city: bucharest_city, email: "person@bucharest.ro", phone: "07277777", verified: true)
    end


    describe "index" do

      before do
        visit url_for_subdomain :cluj, "/admin/people"
        login 
      end

      it "should display all the people" do
        expect(people_nodes[0]).to have_content("Person 1 Bucharest")
        expect(people_nodes[1]).to have_content("Person 1 Cluj")  
      end

      it "should order by id" do
        click_link('Id')

        expect(people_nodes[1]).to have_content("Person 1 Bucharest")
        expect(people_nodes[0]).to have_content("Person 1 Cluj")  
      end

      it "should order by name" do
        click_link('Name')

        expect(people_nodes[1]).to have_content("Person 1 Bucharest")
        expect(people_nodes[0]).to have_content("Person 1 Cluj")  
      end

      it "should order by email" do
        click_link('Email')

        expect(people_nodes[0]).to have_content("Person 1 Cluj")  
        expect(people_nodes[1]).to have_content("Person 1 Bucharest")
      end

      it "should filter by cities" do      
        select "Cluj", :from => "q_city_id"
        click_button "Filter"

        expect(people_nodes.count).to eq(1)
        expect(people_nodes[0]).to have_content("Person 1 Cluj") 
      end

      it "should filter by name" do      
        fill_in :q_name, with: "Cluj"
        click_button "Filter"

        expect(people_nodes.count).to eq(1)
        expect(people_nodes[0]).to have_content("Person 1 Cluj") 
      end

      it "should filter by email" do      
        fill_in :q_email, with: "Cluj"
        click_button "Filter"

        expect(people_nodes.count).to eq(1)
        expect(people_nodes[0]).to have_content("Person 1 Cluj") 
      end

      it "should delete a person", js: true do
        alert_text = page.accept_confirm do
          within people_nodes[0] do
            click_link "Delete"
          end
        end

        expect(Person.count).to eq(1)
      end

      it "should create a person" do
        click_link "New Person"
        fill_in "person_name", with: "test"
        fill_in "person_email", with: "test@address.ro"
        check :person_verified
        select "Cluj", :from => "person_city_id"
        fill_in :person_phone, with: "0741441433"
        click_button "Create Person" 
        
        # we make sure the page is loaded
        expect(page).to have_content("Person Details")
        person = Person.find(3)
        expect(person.city_id).to eq(1)
        expect(person.name).to eq("test")
        expect(person.email).to eq("test@address.ro")
        expect(person.verified).to eq(true)
      end
    end


    describe "view" do

      before do
        visit url_for_subdomain :cluj, "/admin/people/1"
        login 
      end

      it "should contain all the elements" do      
        expect(page).to have_content('Person 1 Cluj')
        expect(page).to have_content('person@cluj.ro')
        expect(page).to have_content('Verified Empty')
      end

      it "should update the location", js: true do      
        click_link "Edit Person"
        fill_in "person_name", with: "test"
        fill_in "person_email", with: "test@address.ro"
        select "Bucharest", :from => "person_city_id"
        uncheck :person_verified
        click_button "Update Person" 
         
        # we make sure the page is loaded
        expect(page).to have_content("Person Details")
        person = Person.find(1)
        expect(person.city_id).to eq(2)
        expect(person.name).to eq("test")
        expect(person.verified).to eq(false)
        expect(person.email).to eq("test@address.ro")
      end
    end

  end
end
