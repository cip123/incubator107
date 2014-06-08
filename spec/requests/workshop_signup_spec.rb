require 'spec_helper'

describe "sign up to workshop" do

  let!(:city) { FactoryGirl.create(:city_with_links, name: 'cluj') }
  let (:signup) { click_button 'Gata'; sleep 2 }
  let (:workshop) { FactoryGirl.create(:workshop_with_events) }
  let (:participant) { FactoryGirl.create(:participant) }

  describe "with invalid data", :js => true do
    before do
      visit url_for_subdomain :cluj, "/workshops/" + workshop.id.to_s
      click_link "aici"; sleep 2
#      save_and_open_page
      fill_in "workshop_participant_participant_name" , :with => ''
      fill_in "workshop_participant_participant_email", :with => 'cip@incubator107.com'
    end

    it "should not allow users without phone number" do
        expect {signup}.not_to change(WorkshopParticipant, :count).by(1)
        expect (page.driver.alert_messages.first).should eq(I18n.t("activerecord.errors.models.participant.attributes.name.blank"))
    end
  end
end

