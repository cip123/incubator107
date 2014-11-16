require 'spec_helper'

describe "Workshop Registration" do

  let(:signup) { click_button 'Gata'}
  
  before(:all) do
    Delayed::Worker.delay_jobs = false
  end

  before do
    ActionMailer::Base.deliveries = []
    @city = FactoryGirl.create(:city_with_links, name: 'cluj')

    @workshop = FactoryGirl.create(:workshop_with_events) 
  
    Timecop.travel(Time.now.change(:day => 1))

    visit url_for_subdomain :cluj, "/workshops/" + @workshop.id.to_s

    click_link "aici"
    sleep 1

    
    @gibbon = object_double("Gibbon::API").as_stubbed_const
    @api = double("api")
    allow(@gibbon).to receive(:new).twice  { @api}
    allow(@api).to receive(:lists).twice { @api }
    allow(@api).to receive(:subscribe).twice
  end
  
  after do
    Timecop.return
  end

  describe "with invalid data", :js => true do

    it "should not allow users without phone number" do
      
      fill_in "registration_person_name" , :with => 'cip'
      fill_in "registration_person_email", :with => 'cip@incubator107.com'
      expect {signup}.not_to change(Person, :count)
      expect(page).to have_content("Telefonul nu este completat")
    end

    it "should not allow persons without name" do
      fill_in "registration_person_phone" , :with => '0754999999'
      fill_in "registration_person_email", :with => 'cip@incubator107.com'
      expect {signup}.not_to change(Person, :count)
      expect(page).to have_content("Numele nu este completat")
    end

    it "should not allow persons without email" do
      fill_in "registration_person_phone" , :with => '0754999999'
      fill_in "registration_person_name", :with => 'cip'
      expect {signup}.not_to change(Person, :count)
      expect(page).to have_content("Emailul nu este completat")
    end

    it "should not allow persons with invalid email" do
      fill_in "registration_person_phone" , :with => '0754999999'
      fill_in "registration_person_email", :with => 'cip@dsada,ro'
      fill_in "registration_person_name", :with => 'cip'
      expect {signup}.not_to change(Person, :count)
      expect(page).to have_content("Emailul este invalid")
    end

  end

  describe "with valid data", :js => true do

    before do

      fill_in "registration_person_phone" , :with => '074834343'
      fill_in "registration_person_name" , :with => 'cip'
      fill_in "registration_reason" , :with => 'Decembrie'
      fill_in "registration_person_email", :with => 'cip@incubator107.com'      
  find(:css, "#event_ids_[value='#{@workshop.events[0].id}']").set(false)
    end

    it "should increase registrations count" do
     
      registrations_before = Registration.all.count


      alert_text = page.accept_alert do
        signup  
      end

      expect (Registration.all.count - registrations_before) == 2

      expect(alert_text) == "Vă mulțumim pentru înscriere!"
      registration_params = {
        id: @city.mailchimp_workshop_list_id, 
        email: {
          email: "cip@incubator107.com"
        },
        merge_vars: {
          groupings: [
            {
            id: @city.mailchimp_workshop_groups_id,
            groups: [ @workshop.group.name ]
            }

          ]
        },
        double_optin: false, 
        replace_interests: false, 
        update_existing: true
      }


      expect(@gibbon).to have_received(:new)
      expect(@api).to have_received(:lists)
      expect(@api).to have_received(:subscribe).with(registration_params)
    
      person = Person.find_by_email("cip@incubator107.com")
     
      registration = Registration.find_by(
        :person_id => person.id,
        :event_id => @workshop.events[1].id
      )
      expect registration !=  nil

      assert registration.reason == "Decembrie"

      registration = Registration.find_by(
        :person_id => person.id,
        :event_id => @workshop.events[2].id
      )
      
      expect registration !=  nil
      assert registration.reason == "Decembrie"


      verify_mail = ActionMailer::Base.deliveries.first
      assert_equal "Email de verificare", verify_mail.subject
      assert_equal "cip@incubator107.com", verify_mail.to[0]
      assert_match( /cluj.lvh.me/, verify_mail.body.to_s )

      reminder_mail = ActionMailer::Base.deliveries[2]
      assert_equal reminder_mail.subject, "Reminder - #{@workshop.name} - #{registration.event.name}"

      welcome_mail = ActionMailer::Base.deliveries.last
      assert_equal "#{@workshop.name} - înscriere online", welcome_mail.subject
      assert_equal "cip@incubator107.com", welcome_mail.to[0]
      assert_match( /atelier/, welcome_mail.body.to_s )

    end


    it "should schedule the job correctly" do 

      Delayed::Worker.delay_jobs = true

      alert_text = page.accept_alert do
        signup  
      end


      expect(Delayed::Job.where(run_at: (@workshop.events[1].start_date.midnight - 16.hours))).to be_present
      expect(Delayed::Job.where(run_at: (@workshop.events[2].start_date.midnight - 16.hours))).to be_present

      Delayed::Worker.delay_jobs = false

    end

    it "should increase subscribe to mailing list" do
     
      check "registration_subscribe_to_mailing_list"
      
      newsletter_subscribers_before = NewsletterSubscriber.all.count

        
      alert_text = page.accept_alert do
        signup  
      end

      expect (NewsletterSubscriber.all.count - newsletter_subscribers_before) == 1

      
      expect alert_text == "Vă mulțumim pentru înscriere!"

      newsletter_subscribe_params = {
        id: @city.mailchimp_newsletter_list_id, 
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

      newsletter_subscriber = NewsletterSubscriber.find_by(
        :email=> "cip@incubator107.com",
        :city_id => @city.id
      )
      expect newsletter_subscriber !=  nil
    end

    describe "with existing not verified person " do

      before do 
        Person.create!(name: "cip", email: "cip@incubator107.com", phone: "0748452880", city: @city)
      end

      it "should not increase person count" do
       
        alert_text = page.accept_alert do
          expect {signup}.not_to change(Person, :count)
        end

        expect alert_text == "Te rugăm sa-ți validezi mailul înainte să te înregistrezi"
      end
    end

    describe "with existing verified person" do

      before do 
        Person.create(name: "cip", email: "cip@incubator107.com", phone: "0748452880", verified: 1, city: @city)
      end

      it "should not increase person count" do

        alert_text = page.accept_alert do
          expect {signup}.not_to change(Person, :count)
        end

        expect alert_text == "Vă mulțumim pentru înscriere!"

        welcome_mail = ActionMailer::Base.deliveries.last
        assert_equal "#{@workshop.name} - înscriere online", welcome_mail.subject
        assert_equal "cip@incubator107.com", welcome_mail.to[0]
        assert_match( /atelier/, welcome_mail.body.to_s )
      end
    end

    describe "when already registered" do

      before do 
        person = Person.create(name: "cip", email: "cip@incubator107.com", phone: "0748452880",verified: 1, city: @city)
        Registration.create(event_id: @workshop.events[0].id, person_id: person.id, reason: "Original reason")
        find(:css, "#event_ids_[value='#{@workshop.events[0].id}']").set(true)       
        find(:css, "#event_ids_[value='#{@workshop.events[1].id}']").set(false)
        find(:css, "#event_ids_[value='#{@workshop.events[2].id}']").set(false)
      end

      it "should not increase workshop people count" do
        
        alert_text = page.accept_alert do
          expect {signup}.not_to change(Registration, :count)
        end

        
        expect alert_text == "Vă mulțumim pentru înscriere!"

      end
    end
  end

end

