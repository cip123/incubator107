require 'spec_helper'

describe "Subscribe to mailing list" do

  let(:subscribe) { click_button I18n.t('home.sign_me_up') }

  before do
    I18n.locale = I18n.default_locale
    @city =  FactoryGirl.create(:city_with_links, name: "cluj") 
    visit url_for_subdomain :cluj, "/"         
  end

  describe "it should subscribe to newsletter" do

    before do
      fill_in "newsletter_subscriber_email", :with => 'cip@incubator107.com'
    end

    it "should increase subscriber count", js: true do

   
     subscribers_count_before = NewsletterSubscriber.count

      alert_text = page.accept_alert do
        subscribe
      end

      expect(NewsletterSubscriber.count - subscribers_count_before).to eq(1)
      expect(alert_text).to eq("Vă mulțumim pentru înscriere!")      
    end
      

    
  end

  describe "existing subscriber"  do

    before do
      NewsletterSubscriber.create(:email => 'cip@incubator107.com', :city => @city )      
      fill_in "newsletter_subscriber_email", :with => 'cip@incubator107.com'
    end


    describe "it should not register it to newsletter", :js => true do

      it "should not increase subscriber count" do

        subscribers_count_before = NewsletterSubscriber.count

        alert_text = page.accept_alert do
          subscribe
        end

        expect(NewsletterSubscriber.count - subscribers_count_before).to eq(0)
        expect(alert_text).to eq("Vă mulțumim pentru înscriere!")      

      end

    end

  end

  describe "when new subscriber with invalid email", :js => true do

    before do
      fill_in "newsletter_subscriber_email", :with => 'cip,22@incubator107.com'
    end

    it "should not increase person count" do

      subscribers_count_before = NewsletterSubscriber.count

      alert_text = page.accept_alert do
        subscribe
      end

      expect(NewsletterSubscriber.count - subscribers_count_before).to eq(0)
      expect(alert_text).to eq("Emailul este invalid")
    end
  end


end
