require 'spec_helper'

describe "sign up to workshop" do

  let!(:city) { FactoryGirl.create(:city_with_links, name: 'cluj') }
  let (:signup) { click_button 'Gata'; sleep 2 }
  let (:workshop) { FactoryGirl.create(:workshop_with_events) }
  let (:participant) { FactoryGirl.create(:participant) }

  before do
    ActionMailer::Base.deliveries = []
    visit url_for_subdomain :cluj, "/workshops/" + workshop.id.to_s
    click_link "aici"; sleep 2
  end
  describe "with invalid data", :js => true do

    it "should not allow users without phone number" do
      fill_in "workshop_participant_participant_name" , :with => 'cip'
      fill_in "workshop_participant_participant_email", :with => 'cip@incubator107.com'
      expect {signup}.not_to change(WorkshopParticipant, :count).by(1)
      expect (page.driver.alert_messages.first).should eq("Telefonul nu este completat")
    end

    it "should not allow participants without name" do
      fill_in "workshop_participant_participant_phone" , :with => '0754999999'
      fill_in "workshop_participant_participant_email", :with => 'cip@incubator107.com'
      expect {signup}.not_to change(WorkshopParticipant, :count).by(1)
      expect (page.driver.alert_messages.first).should eq("Numele nu este completat")
    end

    it "should not allow participants without email" do
      fill_in "workshop_participant_participant_phone" , :with => '0754999999'
      fill_in "workshop_participant_participant_name", :with => 'cip'
      expect {signup}.not_to change(WorkshopParticipant, :count).by(1)
      expect (page.driver.alert_messages.first).should eq("Emailul nu este completat")
    end
  end

  describe "with valid data", :js => true do

    before do
      fill_in "workshop_participant_participant_name" , :with => 'cip'
      fill_in "workshop_participant_participant_phone" , :with => '074834343'
      fill_in "workshop_participant_reason" , :with => 'Decembrie'
      fill_in "workshop_participant_participant_email", :with => 'cip@incubator107.com'
    end

    it "should increase workshop participants count" do
      expect {signup}.to change(WorkshopParticipant, :count).by(1)
      expect (page.driver.alert_messages.first).should eq("Vă mulțumim pentru înscriere!")
      participant = Participant.find_by_email("cip@incubator107.com")
      workshop_participant = WorkshopParticipant.find_by(
        :participant_id => participant.id,
        :workshop_id => workshop.id
      )
      expect workshop_participant !=  nil
      assert workshop_participant.reason == "Decembrie"
      verify_mail = ActionMailer::Base.deliveries.last
      assert_equal "Email de verificare", verify_mail.subject
      assert_equal "cip@incubator107.com", verify_mail.to[0]
      assert_match( /cluj.incubator107.com/, verify_mail.body.to_s )

    end

    it "should increase subscribe to mailing list" do
      check "workshop_participant_subscribe_to_mailing_list"
      expect {signup}.to change(MailingListSubscriber, :count).by(1)
      expect (page.driver.alert_messages.first).should eq("Vă mulțumim pentru înscriere!")
      subscriber = Subscriber.find_by_email("cip@incubator107.com")
      mailing_list_subscriber = MailingListSubscriber.find_by(
        :subscriber_id => subscriber.id,
        :mailing_list_id => city.mailing_list_id
      )
      expect mailing_list_subscriber !=  nil
    end

    describe "with existing not verified participant " do

      before do 
        Participant.create(name: "cip", email: "cip@incubator107.com", phone: "0748452880")
      end

      it "should not increase participant count" do
        expect {signup}.not_to change(Participant, :count).by(1)
        expect (page.driver.alert_messages.first).should eq("Te rugăm sa-ți validezi mailul înainte să te înregistrezi")
      end
    end

    describe "with existing verified participant" do

      before do 
        Participant.create(name: "cip", email: "cip@incubator107.com", phone: "0748452880", verified: 1)
      end

      it "should not increase participant count" do
        expect {signup}.not_to change(Participant, :count).by(1)
        expect (page.driver.alert_messages.first).should eq("Vă mulțumim pentru înscriere!")
        welcome_mail = ActionMailer::Base.deliveries.last
        assert_equal "#{workshop.name} - înscriere online", welcome_mail.subject
        assert_equal "cip@incubator107.com", welcome_mail.to[0]
        assert_match( /atelier/, welcome_mail.body.to_s )
      end
    end

    describe "when already registered" do

      before do 
        participant = Participant.create(name: "cip", email: "cip@incubator107.com", phone: "0748452880",verified: 1)
        WorkshopParticipant.create(workshop_id: workshop.id, participant_id: participant.id)
      end

      it "should not increase workshop participants count" do
        expect {signup}.not_to change(WorkshopParticipant, :count).by(1)
        expect (page.driver.alert_messages.first).should eq("Vă mulțumim pentru înscriere!")
      end
    end
  end

end

