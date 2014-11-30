require 'spec_helper'

describe "Subscribe to mailing list" do

  let(:subscribe) {         page.execute_script %Q{
          $("form#new_newsletter_subscriber").submit();
        }   }

  before do
    I18n.locale = I18n.default_locale
    @city =  FactoryGirl.create(:city_with_links, name: "cluj") 
    visit url_for_subdomain :cluj, "/"   
    page.execute_script('$("#subscribe-newsletter").click()')
  end

  describe "it should subscribe to newsletter" do

    it "should increase subscriber count", js: true  do
      
      page.execute_script('$("#newsletter_subscriber_email").val("cip@incubator107.com")') 
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
    end


    describe "it should not register it to newsletter", :js => true do

      it "should not increase subscriber count" do

        subscribers_count_before = NewsletterSubscriber.count
        page.execute_script('$("#newsletter_subscriber_email").val("cip@incubator107.com")') 

        alert_text = page.accept_alert do
          subscribe
        end

        expect(NewsletterSubscriber.count - subscribers_count_before).to eq(0)
        expect(alert_text).to eq("Vă mulțumim pentru înscriere!")      

      end

    end

  end

  describe "when new subscriber with invalid email", :js => true do

    it "should not increase person count" do

      page.execute_script('$("#newsletter_subscriber_email").val("cip,2@incubator107.com")') 
      subscribers_count_before = NewsletterSubscriber.count

      alert_text = page.accept_alert do
        subscribe
      end

      expect(NewsletterSubscriber.count - subscribers_count_before).to eq(0)
      expect(alert_text).to eq("Emailul este invalid")
    end
  end


end
