require 'spec_helper'

describe "Participant pages" do


  let!(:city) { FactoryGirl.create(:city_with_links) }
  let!(:participant) { FactoryGirl.create(:participant) }
  let!(:workshop) { FactoryGirl.create(:workshop) }

  describe "when the user already validated his email" do
    let!(:workshop_participant) { FactoryGirl.create(:workshop_participant, :workshop_id => workshop.id, :participant_id => participant.id) }
    before do
      crypt = ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
      participant.verified  = true
      participant.save
      token = crypt.encrypt_and_sign(participant.id)
      visit url_for_subdomain "cluj", "/verify?token=#{token}"
    end

    it "should not send an email" do
      assert_equal 0, ActionMailer::Base.deliveries.count
    end
  end

  describe " when the user did not validate the email" do

    let!(:workshop_participant) { FactoryGirl.create(:workshop_participant, :workshop_id => workshop.id, :participant_id => participant.id) }
    before do
      crypt = ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
      token = crypt.encrypt_and_sign(participant.id)
      visit url_for_subdomain "cluj", "/verify?token=#{token}"
    end
    it "should send the pending mail" do
      participant.reload
      assert_equal true, participant.verified
      welcome_mail = ActionMailer::Base.deliveries.last
      assert_equal "#{workshop.name} - înscriere online", welcome_mail.subject
      assert_equal "cip@incubator107.com", welcome_mail.to[0]
      assert_match( /atelier/, welcome_mail.body.to_s )
    end

  end

end
