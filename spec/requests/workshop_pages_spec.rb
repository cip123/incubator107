require 'spec_helper'

describe "Workshops pages" do

  before do 
    I18n.locale = I18n.default_locale
    @city = FactoryGirl.create(:city_with_links)
  end

  describe "index" do
    describe "pagination" do
      before do
        30.times do |n|
          FactoryGirl.create(:workshop, city_id: @city.id) 
        end
        visit url_for_subdomain :cluj, "/workshops" 
      end
      it "should have the correct title" do
        expect(page).to have_title(I18n.t(:workshops))
      end

      it "should list each workshop" do
        expect(page).to have_selector('div.pagination') 
        Workshop.paginate(page: 1).each do |workshop|
          # TODO expect a href to have content
          expect(page).to have_content(workshop.name)
        end
      end
    end

    describe "group dropdown" do
      before  do
        Group.delete_all
        Workshop.delete_all
        5.times do 
          group = FactoryGirl.create(:group)
          2.times do 
            workshop = FactoryGirl.create(:workshop, group_id: group.id, city_id: @city.id) 
          end
        end

        visit url_for_subdomain :cluj, "/groups" 
      end

      it "should have default the correct values" do
        Group.all.each do |group|
          expect(page).to have_content(group.name)
        end
      end

      describe "when selecting a group" do
        before do
          click_link Group.first.name
        end

        it "should list only the workshops for that group" do

          within('div #workshops') do |ref|
            expect(page).to have_content(Workshop.first.name)
            expect(page).to have_content(Workshop.limit(1).offset(1).first.name)
            expect(page).not_to have_content(Workshop.limit(1).offset(2).first.name)
          end
        
        end
      end
    end
  end

  describe "show" do

    before do
      @workshop = FactoryGirl.create(:workshop_with_events)
    end

    describe "with donation" do

      before do
        @koala = object_double("Koala::Facebook::API").as_stubbed_const
        @facebook_api = double("api");

        allow(@koala).to receive(:new)  { @facebook_api}
        allow(@facebook_api).to receive(:api) { { data: "test" } }
        
        visit url_for_subdomain :cluj, workshop_path(@workshop.id)
      end

      it "should display all the fields" do      

        expect(@koala).to have_received(:new)
        expect(@facebook_api).to have_received(:api).with("/#{@workshop.facebook_album_id}/photos?fields=source,picture")

        expect(page).to have_content("descriptiontest")
        expect(page).to have_content("requisitetest")
        expect(page).to have_content("mastertest")
        expect(page).to have_content( I18n.l(@workshop.events.first.start_date, :format => '%A'))
        expect(page).to have_content('wheretest')
        expect(page).to have_content('donationtest')
        expect(page).to have_content(I18n.t(:signup_is_online))
        expect(page).to have_content(I18n.t(:signup_blah_blah))
      end
    end
    
    describe "without donation" do

      before do
        @workshop.requires_donation = false
        @workshop.save
        visit url_for_subdomain :cluj, workshop_path(@workshop.id)
      end

      it "should display all the fields" do      
        expect(page).to have_content("descriptiontest")
        expect(page).to have_content("requisitetest")
        expect(page).to have_content("mastertest")
        expect(page).to have_content( I18n.l(@workshop.events.first.start_date, :format => '%A'))
        expect(page).to have_content('wheretest')
        expect(page).to have_content(I18n.t(:signup_is_online))
        expect(page).to have_content(I18n.t(:signup_blah_blah))
        expect(page).not_to have_content('donationtest')
        expect(page).not_to have_content('daca nu va')
      end
    end
  end

end
