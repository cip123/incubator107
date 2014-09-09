require 'spec_helper'



describe "Subscribe to mailing list" do




  let!(:city) { FactoryGirl.create(:city_with_links, name: "cluj") }

  let(:subscribe)  {click_button I18n.t('home.sign_me_up'); sleep 2 }

  describe "when new subscriber with valid data"  do

    describe "it should save and register it to newsletter", :js => true do


      before do
        visit url_for_subdomain :cluj, "/"
        fill_in "newsletter_subscriber_email", :with => 'cip@incubator107.com'
      end

      it "should increase subscriber count" do
        expect {subscribe}.to  change(NewsletterSubscriber, :count).by(1)
        page.accept_alert "e" do
          puts accept a
        end
        expect(page.driver.alert_messages.first).to eq(I18n.t(:thank_you_for_registering))     
      end

    end
  end

  describe "existing subscriber"  do

    before do
      NewsletterSubscriber.create(:email => 'cip@incubator107.com', :city => city)
      visit url_for_subdomain :cluj, "/"
      fill_in "newsletter_subscriber_email", :with => 'cip@incubator107.com'
    end


    describe "it should not register it to newsletter", :js => true do

      it "should not increase subscriber count" do
        expect {subscribe}.not_to change(NewsletterSubscriber, :count)
        expect(page.driver.alert_messages.first).to eq(I18n.t(:thank_you_for_registering))       
      end

    end

  end

  describe "when new subscriber with invalid email", :js => true do

    before do
      visit url_for_subdomain :cluj, "/"
      fill_in "newsletter_subscriber_email", :with => 'cip,22@incubator107.com'
    end

    it "should not increase person count" do
        expect {subscribe}.not_to change(NewsletterSubscriber, :count)
        expect(page.driver.alert_messages.first).to eq(I18n.t("activerecord.errors.models.subscriber.attributes.email.invalid"))
     end
  end


end
