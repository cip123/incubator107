require 'spec_helper'

describe "Location pages" do

  let!(:city) { FactoryGirl.create(:city) }
  let(:user) { FactoryGirl.create(:super_admin_user) }

  describe "index" do


    before do
      sign_in user
      visit url_for_subdomain "cluj", locations_path
    end

    it "should list the users page" do
      expect(page).to have_content('Listing locations')
      expect(page).to have_title('Locations')
    end

    describe "pagination" do

      before(:all) { 31.times { FactoryGirl.create(:location) } }
      after(:all)  { Location.delete_all }

      it "should list each user" do

        expect(page).to have_selector('div.pagination')
        expect(page).to have_selector('div.pagination')
        Location.paginate(page: 1).each do |location|
          expect(page).to have_link(location.name, href: edit_location_path(location))
        end
      end
    end
  end

  describe "edit location" do

    let!(:location) { FactoryGirl.create(:location) }

    before do
      sign_in user
      visit url_for_subdomain "cluj", edit_location_path(location)
    end


    it "should display the correct edit page" do
      expect(page).to have_content("Edit location")
      expect(page).to have_title( location.name)
    end

    describe "with valid information" do

      it "should display the updated home page" do

        fill_in "Name",             with: "Location Test"
        fill_in "Address",            with: "Address Test"
        fill_in "Description",         with: "Description Test"
        click_button "Save changes"

        expect(page).to have_title("Locations")
        expect(page).to have_selector('div.alert.alert-success')
        location.reload
        expect(location.name).to  eq "Location Test"
        expect(location.address).to  eq "Address Test"
        expect(location.description).to  eq "Description Test"

      end
    end

    describe "with invalid information" do


      let(:submit) { "Save changes" }

      it "should not create the location" do
        fill_in "Name",             with: ""
        click_button submit
        expect(page).to have_content('error')
      end
    end

    describe "delete a location" do


      let(:submit) { "Delete location" }

      it "should delete the location" do
        
        expect { click_button submit }.to change(Location, :count).by(-1)
      end

    end

  end

  describe "new location" do

    let(:submit) { "Create location" }

    before do
      sign_in user
      visit url_for_subdomain "cluj", new_location_path
    end


    it "should display the correct edit page" do
      expect(page).to have_content("New location")
      expect(page).to have_title( "New location")
    end

    describe "with valid information" do

      it "should display the updated home page" do

        fill_in "Name",             with: "Location Test"
        fill_in "Address",            with: "Address Test"
        fill_in "Description",         with: "Description Test"

        expect { click_button submit }.to change(Location, :count).by(1)

        expect(page).to have_title("Locations")
        expect(page).to have_selector('div.alert.alert-success')

        location = Location.last
        expect(location.name).to  eq "Location Test"
        expect(location.address).to  eq "Address Test"
        expect(location.description).to  eq "Description Test"
      end
    end

    describe "with invalid information" do

      it "should not create the location" do
        expect { click_button submit }.not_to change(Location, :count).by(1)
        expect(page).to have_title('New location')
        expect(page).to have_content('error')
      end

    end

  end

  describe "authorization"  do


    let!(:location) { FactoryGirl.create(:location) }

    it "should redirect to admin home when visiting the edit location page" do
      visit url_for_subdomain "cluj", edit_location_path(location)
      expect(page).to have_title('Sign in')
    end

    it "should redirect to admin home when creating a location" do
      post url_for_subdomain "cluj", locations_path
      expect(response).to redirect_to(signin_path)
    end


    it "should redirect to admin home when visiting new location page" do
      get url_for_subdomain "cluj", new_location_path
      expect(response).to redirect_to(signin_path)
    end

    it "should redirect to admin home when deleting a location" do
      delete url_for_subdomain "cluj", location_path(location)
      expect(response).to redirect_to(signin_path)
    end

    it "should redirect to admin home when updating a location" do
      put url_for_subdomain "cluj", location_path(location)
      expect(response).to redirect_to(signin_path)
    end


    it "should redirect to admin home visiting the location index" do
      visit url_for_subdomain "cluj", locations_path
      expect(page).to have_title('Sign in')
    end
  end

end
