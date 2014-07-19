require 'spec_helper'



describe "Subscribe to mailing list" do

  let!(:city) { FactoryGirl.create(:city_with_links, name: "cluj") }

  let(:subscribe)  {click_button I18n.t('home.sign_me_up'); sleep 2 }

  describe "when new subscriber with valid data"  do

    describe "it should save and register it to newsletter", :js => true do


      before do
        visit url_for_subdomain :cluj, "/"
        fill_in "subscriber_email", :with => 'cip@incubator107.com'
      end

      it "should increase subscriber count" do
        expect {subscribe}.to  change(Subscriber, :count).by(1)
        expect (page.driver.alert_messages.first).should eq(I18n.t(:thank_you_for_registering))     
      end

    end
  end

  describe "existing subscriber"  do

    before do
      Subscriber.create(:email => 'cip@incubator107.com', :mailing_list_id => city.mailing_list_id)
      visit url_for_subdomain :cluj, "/"
      fill_in "subscriber_email", :with => 'cip@incubator107.com'
    end


    describe "it should not register it to newsletter", :js => true do

      it "should not increase subscriber count" do
        expect {subscribe}.not_to change(Subscriber, :count).by(1)
        expect (page.driver.alert_messages.first).should eq(I18n.t(:thank_you_for_registering))       
      end

    end

  end

  describe "when new subscriber with invalid email", :js => true do

    before do
      visit url_for_subdomain :cluj, "/"
      fill_in "subscriber_email", :with => 'cip,22@incubator107.com'
    end

    it "should not increase participant count" do
        expect {subscribe}.not_to change(Subscriber, :count).by(1)
        expect (page.driver.alert_messages.first).should eq(I18n.t("activerecord.errors.models.subscriber.attributes.email.invalid"))
     end
  end


end
