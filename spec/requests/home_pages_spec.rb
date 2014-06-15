require "spec_helper"

describe "Home pages" do

  subject { page }

  describe " navigation bar " do
    I18n.available_locales.each do |locale|

      describe "with #{locale} locale" do
        let!(:city) { FactoryGirl.create(:city_with_links) }

        if (locale == I18n.default_locale)
          locale = ""
        end

        before do          
          visit url_for_subdomain :cluj, "/", locale
        end

        it { should have_title "incubator107 #{city.name} " }
        it { should_not have_link "Sign in" }
        it { should_not have_link "Home" }
        it { should have_content "Last news" }
        it { should have_link ( I18n.t(:who_are_we)), :href => article_path(:id => 1) }
        it { should have_link I18n.t(:workshops), :href => workshops_path }
        it { should have_link I18n.t(:calendar)}
        it { should have_link I18n.t(:collaboration)}
        it { should have_link I18n.t(:your_place)}
        it { should have_link I18n.t(:friends)}
        it { should have_link I18n.t(:two_percent)}
        it { should have_link I18n.t(:contact) }

      end
    end
  end

  describe "side bar" do
    let!(:city) { FactoryGirl.create(:city_with_links, name: 'cluj') }
    describe "when beginning of the month" do
      before do
        t = Time.now
        I18n.locale == I18n.default_locale
        Time.stub(:now) { t.change(:day => 15) }        
        FactoryGirl.create(:workshop_with_events, name: "spanning_workshop")  
        FactoryGirl.create(:workshop_with_events, name: "inactive workshop", published: false)  
        visit url_for_subdomain :cluj, "/"
      end

      it { should have_link "spanning_workshop" }
      it "should contain header 'this month'" do
        save_and_open_page  
        expect(page).to have_content("Luna aceasta") 
      end
      it { should_not have_content "Luna viitoare" }
    end

    describe "when at end of the month" do
      before do
        t = Time.now
        Time.stub(:now) { t.change(:day => 25) }       
        FactoryGirl.create(:workshop_with_events, name: "spanning_workshop")  
        visit url_for_subdomain :cluj, "/"
      end
      
      it { should have_link "spanning_workshop" }
      it { should have_content "Luna aceasta" }
      it { should have_content "Luna viitoare" }
    end
  end

end
