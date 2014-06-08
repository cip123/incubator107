require 'spec_helper'

describe "Workshops pages" do


  let!(:city) { FactoryGirl.create(:city_with_links) }


  describe "index" do
    describe "pagination" do
      before do
        30.times do |n|
          FactoryGirl.create(:workshop) 
        end
        visit url_for_subdomain :cluj, "/workshops" 
      end
      it "should have the correct title" do
        expect(page).to have_title(I18n.t(:workshops))
      end


      it "should list each workshop" do
        expect(page).to have_selector('div.pagination') 
        Workshop.paginate(page: 1).each do |workshop|
          #todo expect a href to have content
          expect(page).to have_content(workshop.name)
        end
      end
    end

    describe "group dropdown" do
      before  do
        Workshop.delete_all
        10.times do |n|
          FactoryGirl.create(:workshop, group_id: 1 + n%5) 
        end
        5.times { FactoryGirl.create(:group) }
        visit url_for_subdomain :cluj, "/workshops" 
      end

      it "should have default the correct values" do
        expect(page).to have_content I18n.t(:all_guilds)
        Group.all.each do |group|
          expect(page).to have_content(group.name)
        end
      end

      describe "when selecting a group" do
        before do
          click_button I18n.t(:all_guilds)
          click_link Group.first.name
        end

        it "should list only the workshops for that group" do
          #save_and_open_pageUser.limit(1).offset(3).first
          within('div #workshops') do |ref|
            expect(page).to have_content(Workshop.first.name)
            expect(page).to have_content(Workshop.limit(1).offset(5).first.name)
            expect(page).not_to have_content(Workshop.limit(1).offset(1).first.name)
          end
        end
      end
    end
  end

  describe "show" do

    let!(:workshop) { FactoryGirl.create(:workshop_with_events) }

    describe "with donation" do

      before do
        visit url_for_subdomain :cluj, workshop_path(workshop.id)
      end

      it "should display all the fields" do      
        expect(page).to have_content("descriptiontest")
        expect(page).to have_content("requisitetest")
        expect(page).to have_content("mastertest")
        expect(page).to have_content( I18n.l(workshop.events.first.start_date, :format => '%A'))
        expect(page).to have_content('wheretest')
        expect(page).to have_content('donationtest')
        expect(page).to have_content(I18n.t(:signup_is_online))
        expect(page).to have_content(I18n.t(:signup_blah_blah))
        expect(page).to have_content('daca nu va')
      end
    end
    
    describe "without donation" do

      before do
        workshop.requires_donation = false
        workshop.save
        visit url_for_subdomain :cluj, workshop_path(workshop.id)
      end

      it "should display all the fields" do      
        expect(page).to have_content("descriptiontest")
        expect(page).to have_content("requisitetest")
        expect(page).to have_content("mastertest")
        expect(page).to have_content( I18n.l(workshop.events.first.start_date, :format => '%A'))
        expect(page).to have_content('wheretest')
        expect(page).to have_content(I18n.t(:signup_is_online))
        expect(page).to have_content(I18n.t(:signup_blah_blah))
        expect(page).not_to have_content('donationtest')
        expect(page).not_to have_content('daca nu va')
      end
    end
  end
end



