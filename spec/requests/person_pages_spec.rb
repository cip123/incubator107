require 'spec_helper'

describe "Person pages" do
 
  before do
    
    I18n.locale = I18n.default_locale
    
    @city = FactoryGirl.create(:city_with_links, name: 'cluj')
    @workshop = FactoryGirl.create(:workshop_with_events)
 
    @person  = FactoryGirl.create(:person, city: @city) 
    @registration =  FactoryGirl.create(:registration, :event => @workshop.events.first, :person => @person) 
  end

  describe "when the user already validated his email" do
    before do
      Delayed::Worker.delay_jobs = false
      ActionMailer::Base.deliveries = []
      crypt = ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
      @person.verified  = true
      @person.save
      token = crypt.encrypt_and_sign(@person.id)
      visit url_for_subdomain "cluj", "/verify?token=#{token}"
    end

    it "should not send an email" do

      assert_equal 0, ActionMailer::Base.deliveries.count
    end
  end

  describe "when the user did not validate the email" do

    before do
      Delayed::Worker.delay_jobs = false
      ActionMailer::Base.deliveries = []
      crypt = ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
      token = crypt.encrypt_and_sign(@person.id)
      visit url_for_subdomain "cluj", "/verify?token=#{token}"
    end

    it "should send the pending mail" do
      @person.reload
      assert_equal true, @person.verified
      welcome_mail = ActionMailer::Base.deliveries.last
      assert_equal "#{@workshop.name} - înscriere online", welcome_mail.subject
      assert_equal @person.email, welcome_mail.to[0]
      assert_match( /atelier/, welcome_mail.body.to_s )
    end

  end

end
