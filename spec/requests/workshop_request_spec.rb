require 'spec_helper'

describe "request a workshop" do

  let!(:city) { FactoryGirl.create(:city_with_links, name: 'cluj') }
  let (:signup) { click_button 'Gata'; sleep 2 }
  let (:workshop) { FactoryGirl.create(:workshop_with_events_in_the_past) }
  let (:person) { FactoryGirl.create(:person) }

  before do
    Delayed::Worker.delay_jobs = false
    ActionMailer::Base.deliveries = []
    visit url_for_subdomain :cluj, "/workshops/" + workshop.id.to_s
    click_link "Cer atelier"; sleep 2
    @gibbon = object_double("Gibbon::API").as_stubbed_const
    @api = double("api")
    allow(@gibbon).to receive(:new).twice  { @api}
    allow(@api).to receive(:lists).twice { @api }
    allow(@api).to receive(:subscribe).twice
    
  end

  describe "with invalid data", :js => true do

    it "should not allow users without phone number" do
      fill_in "workshop_request_person_name" , :with => 'cip'
      fill_in "workshop_request_person_email", :with => 'cip@incubator107.com'
      expect {signup}.not_to change(Person, :count)
      expect(page).to have_content("Telefonul nu este completat")
    end

    it "should not allow persons without name" do
      fill_in "workshop_request_person_phone" , :with => '0754999999'
      fill_in "workshop_request_person_email", :with => 'cip@incubator107.com'
      expect {signup}.not_to change(Person, :count)
      expect(page).to have_content("Numele nu este completat")
    end

    it "should not allow persons without email" do
      fill_in "workshop_request_person_phone" , :with => '0754999999'
      fill_in "workshop_request_person_name", :with => 'cip'
      expect {signup}.not_to change(Person, :count)
      expect(page).to have_content("Emailul nu este completat")
    end

    it "should not allow persons with invalid email" do
      fill_in "workshop_request_person_phone" , :with => '0754999999'
      fill_in "workshop_request_person_email", :with => 'cip@dsada,ro'
      fill_in "workshop_request_person_name", :with => 'cip'
      expect {signup}.not_to change(Person, :count)
      expect(page).to have_content("Emailul este invalid")
    end
  end

  describe "with valid data", :js => true do

    before do
      fill_in "workshop_request_person_name" , :with => 'cip'
      fill_in "workshop_request_person_phone" , :with => '074834343'      
      fill_in "workshop_request_person_email", :with => 'cip@incubator107.com'
      fill_in "workshop_request_reason" , :with => 'Decembrie'
    end

    it "should increase workshop request count" do

      expect {signup}.to change(WorkshopRequest, :count).by(1)

      expect (page.driver.alert_messages.first)  == "Mulțumim!"  

      workshop_request_params = {
        id: city.workshop_list_id, 
        email: {
          email: "cip@incubator107.com"
        },
        merge_vars: {
          groupings: [
            {
            id: city.workshop_groups_id,
            groups: [ workshop.group.name ]
            }

          ]
        },
        double_optin: false, 
        replace_interests: false, 
        update_existing: true
      }

      expect(@gibbon).to have_received(:new)
      expect(@api).to have_received(:lists)
      expect(@api).to have_received(:subscribe).with(workshop_request_params)
      
      person = Person.find_by_email("cip@incubator107.com")

      workshop_request = WorkshopRequest.find_by(
        :person_id => person.id,
        :workshop_id => workshop.id
      )

      expect workshop_request !=  nil
      assert workshop_request.reason == "Decembrie"

      subscriber = NewsletterSubscriber.find_by(
        :email => person.email,
        :city_id => city.id
      )

      expect subscriber !=  nil

      verify_mail = ActionMailer::Base.deliveries.last
      assert_equal "Email de verificare", verify_mail.subject
      assert_equal "cip@incubator107.com", verify_mail.to[0]
      assert_match( /cluj.lvh.me/, verify_mail.body.to_s )

    end

    it "should increase subscribe to mailing list" do
      check "workshop_request_subscribe_to_mailing_list"
      expect {signup}.to change(NewsletterSubscriber, :count).by(1)
      expect (page.driver.alert_messages.first).should eq("Mulțumim!")
      newsletter_list_subscriber = NewsletterSubscriber.find_by(
        :email=> "cip@incubator107.com",
        :city_id => city.id
      )

      expect newsletter_list_subscriber !=  nil

      newsletter_subscribe_params = {
        id: city.newsletter_list_id, 
        email: {
          email: "cip@incubator107.com"
        },
        merge_vars: {
        },
        double_optin: false, 
        replace_interests: false, 
        update_existing: true
      }

      expect(@gibbon).to have_received(:new).twice
      expect(@api).to have_received(:lists).twice
      expect(@api).to have_received(:subscribe).with(newsletter_subscribe_params)
    end

    describe "with existing not verified person " do

      before do
        Person.create!(name: "cip", email: "cip@incubator107.com", phone: "0748452880", city: city)
      end

      it "should not increase person count" do
        expect {signup}.not_to change(Person, :count)
        expect (page.driver.alert_messages.first).should eq("Te rugăm sa-ți validezi mailul înainte să te înregistrezi")
      end
    end

    describe "with existing verified person" do

      before do
        Person.create(name: "cip", email: "cip@incubator107.com", phone: "0748452880", verified: 1, city: city)
      end

      it "should not increase person count" do
        expect {signup}.not_to change(Person, :count)
        expect (page.driver.alert_messages.first).should eq("Mulțumim!")
      end
    end

    describe "when already requested by the same person" do

      before do
        person = Person.create(name: "cip", email: "cip@incubator107.com", phone: "0748452880",verified: 1, city: city)
        WorkshopRequest.create( workshop_id: workshop.id, person_id: person.id )
      end

      it "should not increase workshop people count" do
        expect {signup}.not_to change(WorkshopRequest, :count)
        expect (page.driver.alert_messages.first).should eq("Mulțumim!")
      end
    end

    describe "when it is the tenth requester" do

      before do
        person = Person.create!(name: "cip", email: "cip@otheraddress.com", phone: "0748452880",verified: 1, city: city)
        9.times do |n| 
          WorkshopRequest.create( workshop_id: workshop.id, person_id: person.id )
        end
      end

      it "should increase workshop request count" do
        expect {signup}.to change(WorkshopRequest, :count).by(1)
        expect (page.driver.alert_messages.first).should eq("Mulțumim!")
        notification_mail = ActionMailer::Base.deliveries.last
        
        assert_equal "#{workshop.name} requested", notification_mail.subject
        assert_equal "noi@incubator107.com", notification_mail.to[0]
        assert_match( /10/, notification_mail.body.to_s )

      end
    end


  end

end
