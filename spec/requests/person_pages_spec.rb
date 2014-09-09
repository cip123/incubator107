require 'spec_helper'

describe "Person pages" do


  let!(:city) { FactoryGirl.create(:city_with_links) }
  let!(:person) { FactoryGirl.create(:person) }
  let!(:workshop) { FactoryGirl.create(:workshop) }
  let!(:event_1) { FactoryGirl.create(:event, :workshop_id => workshop.id) }
  let!(:event_2) { FactoryGirl.create(:event, :workshop_id => workshop.id) }

  describe "when the user already validated his email" do
    let!(:registration) { FactoryGirl.create(:registration, :event_id => event_1.id, :person_id => person.id) }

    before do
      crypt = ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
      person.verified  = true
      person.save
      token = crypt.encrypt_and_sign(person.id)
      visit url_for_subdomain "cluj", "/verify?token=#{token}"
    end

    it "should not send an email" do
      assert_equal 0, ActionMailer::Base.deliveries.count
    end
  end

  describe " when the user did not validate the email" do

    let!(:registration) { FactoryGirl.create(:registration, :event_id => event_1.id, :person_id => person.id) }
    before do
      crypt = ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
      token = crypt.encrypt_and_sign(person.id)
      visit url_for_subdomain "cluj", "/verify?token=#{token}"
    end
    it "should send the pending mail" do
      person.reload
      assert_equal true, person.verified
      welcome_mail = ActionMailer::Base.deliveries.last
      assert_equal "#{workshop.name} - înscriere online", welcome_mail.subject
      assert_equal "cip@incubator107.com", welcome_mail.to[0]
      assert_match( /atelier/, welcome_mail.body.to_s )
    end

  end

end
