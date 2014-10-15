require "spec_helper"

describe "Home pages" do

  describe " navigation bar " do
    I18n.available_locales.each do |locale|

      describe "with #{locale} locale" do
        if (locale == I18n.default_locale)
          locale = ""
        end

        before do
          @city = FactoryGirl.create(:city_with_links)
          visit url_for_subdomain :cluj, "/", locale
        end

        it "should have the correct links" do
          expect(page).to have_title "incubator107 #{@city.name} "
          expect(page).not_to have_link "Sign in"
          expect(page).not_to have_link "Home"
          expect(page).to have_content "Last news"
          expect(page).to have_link ( I18n.t(:who_are_we)), :href => article_path(:id => 1)
          expect(page).to have_link I18n.t(:workshops), :href => workshops_path
          expect(page).to have_link I18n.t(:calendar)
          expect(page).to have_link I18n.t(:collaboration)
          expect(page).to have_link I18n.t(:your_place)
          expect(page).to have_link I18n.t(:friends)
          expect(page).to have_link I18n.t(:two_percent)
          expect(page).to have_link I18n.t(:contact)
        end
      end


    end
    
    I18n.locale = I18n.default_locale

  end

  describe "side bar" do

    describe "when beginning of the month" do

      before do

        I18n.locale = I18n.default_locale
        @city = FactoryGirl.create(:city_with_links)

        FactoryGirl.create(:workshop_with_events, name: "spanning_workshop", city_id: @city.id)
        FactoryGirl.create(:workshop_with_events, name: "inactive workshop", city_id: @city.id, published: false)

        allow(Time).to receive(:now).and_return( Time.now.change(:day => 15) )
        
        visit url_for_subdomain :cluj, "/"

      end

      it "should have this month workshops" do

        expect(page).to have_content("Luna aceasta")
        expect(page).to have_link "spanning_workshop"
        expect(page).not_to have_content "Luna viitoare"
      end

    end

    describe "when at end of the month" do

      before do
        I18n.locale = I18n.default_locale
        @city = FactoryGirl.create(:city_with_links)
        
        FactoryGirl.create(:workshop_with_events, name: "spanning_workshop", city_id: @city.id)

        allow(Time).to receive(:now).and_return( Time.now.change(:day => 25) )

        visit url_for_subdomain :cluj, "/"

      end

      it "should have next month workshops" do
        
        expect(page).to have_content("Luna aceasta")
        expect(page).to have_content("Luna viitoare")
        expect(page).to have_link "spanning_workshop"
      end
    end
  end

end
