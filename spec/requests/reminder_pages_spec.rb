require 'spec_helper'

describe "Reminders" do

  let(:signup) { click_button 'Gata'}

  let!(:city) { FactoryGirl.create(:city_with_links, name: 'cluj') }
  let!(:workshop) { FactoryGirl.create(:workshop, city: city) }
  let!(:event) { FactoryGirl.create(:event, workshop: workshop, start_date: Date.today + 1.days) }

  before do
    ActionMailer::Base.deliveries = []
    
    Timecop.return
    
    visit url_for_subdomain :cluj, "/workshops/" + workshop.id.to_s
    click_link "aici"
    
    @gibbon = object_double("Gibbon::API").as_stubbed_const
    @api = double("api")
    allow(@gibbon).to receive(:new).twice  { @api}
    allow(@api).to receive(:lists).twice { @api }
    allow(@api).to receive(:subscribe).twice
  end

  describe "with valid data", :js => true do

    before do
      fill_in "registration_person_phone" , :with => '074834343'
      fill_in "registration_person_name" , :with => 'cip'
      fill_in "registration_reason" , :with => 'Decembrie'
      fill_in "registration_person_email", :with => 'cip@incubator107.com'
    end

    it "should schedule the job correctly" do 


      Delayed::Worker.delay_jobs = true
      alert_text = page.accept_alert do
        signup  
      end
      
      
      Timecop.travel(Date.today.at_midnight + 8.hours)
      
      sleep(10)

      Delayed::Worker.new.work_off 
      reminder_mail = ActionMailer::Base.deliveries[0]
      assert_equal reminder_mail.subject, "Reminder - #{workshop.name} - #{event.name}"
      registration = Registration.first
      expect(registration.notification_sent).to eq(true)
      Timecop.return
    end

  end

end

