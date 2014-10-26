require 'spec_helper'
include Devise::TestHelpers


describe "Workshop" do

  let!(:cluj_city) { FactoryGirl.create(:city, name: "Cluj", default_whereabouts: "prin cluj" ) }
  let!(:bucharest_city) { FactoryGirl.create(:city, domain: :bucharest, name: "Bucuresti", email: "bucuresti@incubator107.com") }
  let!(:group_cluj) { FactoryGirl.create(:group) }
  let!(:group_bucharest) { FactoryGirl.create(:group) }
  let!(:workshop_cluj) { FactoryGirl.create(:workshop, name: "Workshop Cluj", city: cluj_city, published: false, group: group_cluj) }
  let!(:workshop_bucharest) { FactoryGirl.create(:workshop, name: "Workshop Bucuresti", city: bucharest_city, group: group_bucharest) }
  let!(:location_cluj) { FactoryGirl.create(:location) }
  let!(:location_bucharest) { FactoryGirl.create(:location) }
  let(:workshop_nodes) { page.all("#index_table_workshops > tbody > tr") }
  let(:login) { 
    fill_in "admin_user_email", :with => 'admin@incubator107.com'
    fill_in "admin_user_password" , :with => "password"
    click_button :Login
  }

  describe "configuration" do 

    let(:resource_class) { Workshop }
    let(:all_resources)  { ActiveAdmin.application.namespaces[:admin].resources }
    let(:resource)       { all_resources[resource_class] }

    it "resource should be configured " do
      expect(ActiveAdmin.application.namespaces[:admin].resources["Workshop"]).not_to be_nil
      expect(resource.defined_actions).to  include(:create, :new, :update, :edit, :index, :show, :destroy)
    end

  end


  describe "pages" do

    before do
      AdminUser.create!(email: 'admin@incubator107.com', password: "password", password_confirmation: "password") 
    end

    describe "index" do

      before do
        visit url_for_subdomain :cluj, "/admin/workshops"
        login 
      end

      it "should display all the workshop" do
        expect(workshop_nodes[0]).to have_content("Workshop Bucuresti")
        expect(workshop_nodes[1]).to have_content("Workshop Cluj")  
      end

      it "should order by id" do
        click_link('Id')

        expect(workshop_nodes[1]).to have_content("Workshop Bucuresti")
        expect(workshop_nodes[0]).to have_content("Workshop Cluj")  
      end

      it "should order by name" do
        click_link('Name')

        expect(workshop_nodes[0]).to have_content("Workshop Cluj")  
        expect(workshop_nodes[1]).to have_content("Workshop Bucuresti")
      end

      it "should order by Published" do
        click_link('Published')

        expect(workshop_nodes[0]).to have_content("Workshop Bucuresti")
        expect(workshop_nodes[1]).to have_content("Workshop Cluj")  
      end

      it "should filter by name" do      
        fill_in :q_translations_name, with: "Cluj"
        click_button "Filter"

        expect(workshop_nodes.count).to eq(1)
        expect(workshop_nodes[0]).to have_content("Workshop Cluj") 
      end

      it "should filter by group" do      
        select group_cluj.name, from: :q_group_id
        click_button "Filter"

        expect(workshop_nodes.count).to eq(1)
        expect(workshop_nodes[0]).to have_content("Workshop Cluj") 
      end

      it "should filter by city" do      
        select "Cluj", from: :q_city_id
        click_button "Filter"

        expect(workshop_nodes.count).to eq(1)
        expect(workshop_nodes[0]).to have_content("Workshop Cluj") 
      end
      
      it "should delete a workshop", js: true do
        alert_text = page.accept_confirm do
          within workshop_nodes[0] do
            click_link "Delete"
          end
        end

        expect(Workshop.count).to eq(1)
      end

      it "should create a workshop", js: true do
        click_link "New Workshop"
        fill_in :workshop_name, with: "test name"
        fill_in :workshop_facebook_album_id, with: "test facebook album"
        select cluj_city.name, from: :workshop_city_id
        select group_cluj.name, from: :workshop_group_id 
        choose :workshop_published_true
        page.execute_script("$('#workshop_release_date').val('21/12/1980')") 
        choose :workshop_should_send_notification_true

        fill_in_tinymce :workshop_description, with: "test description"
        fill_in_tinymce :workshop_with_whom, with: "test with whom"
        fill_in_tinymce :workshop_bring_along, with: "test bring along"

        click_button "Create Workshop" 

        # we make sure the page is loaded
        expect(page).to have_content("Workshop Details")
        workshop = Workshop.find(3)
        expect(workshop.name).to eq("test name")
        expect(workshop.facebook_album_id).to eq("test facebook album")
        expect(workshop.group).to eq(group_cluj)
        expect(workshop.published).to eq(true)
        expect(workshop.release_date.to_s).to eq("1980-12-21 00:00:00 UTC")
        expect(workshop.should_send_notification?).to eq(true)

        expect(workshop.description).to eq("<p>test description</p>")
        expect(workshop.with_whom).to eq("<p>test with whom</p>")
        expect(workshop.bring_along).to eq("<p>test bring along</p>")
        expect(workshop.whereabouts).to eq("<p>#{cluj_city.default_whereabouts}</p>")
        expect(workshop.requires_donation?).to eq(true)
        expect(workshop.donation).to eq("<p>#{cluj_city.default_donation}</p>")
      end

    end

    describe "view" do

      before do
        visit url_for_subdomain :cluj, "/admin/workshops/1"
        login 
      end

      it "should contain all the elements" do      

        expect(page).to have_content(cluj_city.name)
        expect(page).to have_content(workshop_cluj.name)
        expect(page).to have_content("descriptiontest")
        expect(page).to have_content("mastertest")
        expect(page).to have_content("requisitetest")
        expect(page).to have_content("wheretest")
        expect(page).to have_content("donationtest")
      end

      it "should update the workshop_request", js: true do      
        click_link "Edit Workshop"

        fill_in :workshop_name, with: "test name"
        fill_in :workshop_facebook_album_id, with: "test facebook album"
        select bucharest_city.name, from: :workshop_city_id
        select group_bucharest.name, from: :workshop_group_id 
        choose :workshop_published_false
        page.execute_script("$('#workshop_release_date').val('21/12/1980')") 
        choose :workshop_should_send_notification_true

        fill_in_tinymce :workshop_description, with: "test description"
        fill_in_tinymce :workshop_with_whom, with: "test with whom"
        fill_in_tinymce :workshop_bring_along, with: "test bring along"

        click_button "Update Workshop" 

        # we make sure the page is loaded
        expect(page).to have_content("Workshop Details")
        workshop = Workshop.find(1)
        expect(workshop.name).to eq("test name")
        expect(workshop.facebook_album_id).to eq("test facebook album")
        expect(workshop.city).to eq(bucharest_city)
        expect(workshop.group).to eq(group_bucharest)
        expect(workshop.published).to eq(false)
        expect(workshop.release_date.to_s).to eq("1980-12-21 00:00:00 UTC")
        expect(workshop.should_send_notification?).to eq(true)

        expect(workshop.description).to eq("<p>test description</p>")
        expect(workshop.with_whom).to eq("<p>test with whom</p>")
        expect(workshop.bring_along).to eq("<p>test bring along</p>")
        expect(workshop.whereabouts).to eq("<p>where<strong>test</strong></p>")
        expect(workshop.requires_donation?).to eq(true)
        expect(workshop.donation).to eq("<p>donation<strong>test</strong></p>")
      end

    end

  end

end
