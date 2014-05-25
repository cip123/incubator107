require "spec_helper"

describe "Home pages" do

  subject { page }

  describe " should have the articles links " do
    I18n.available_locales.each do |locale| 

      I18n.locale = locale

      # TODO is should be only one factory method here
      if locale.to_s == 'en'
        let (:city) { FactoryGirl.create(:city_with_english_locale) }
      else
        let (:city) { FactoryGirl.create(:city_with_romanian_locale) }
      end 

      describe "with #{locale} locale" do
        before do
          subdomain = city.domain[/city-\d+/]
          visit url_for_subdomain subdomain, "/#{locale}/" 
        end

        it { should have_title "incubator107 "+city.name }
        it { should_not have_link "Sign in" }
        it { should_not have_link "Home" }
        it { should have_link I18n.t(:who_are_we) }
        it { should have_link I18n.t(:workshops)}
        it { should have_link I18n.t(:contact) }

        #        describe "when visiting the about page" do
        #          before do
        #            click_link I18n.t(:who_are_we) 
        #          end

        #          it { should have_title I18n.t(:what_is_incubator107) }
        #        end
      end
    end  
  end

  describe "it should have workshops links" do
    let (:city) { FactoryGirl.create(:city_with_links) }
    let (:workshop) { FactoryGirl.create(:workshop, city_id: city.id) }

    before do 
      puts workshop.inspect
      subdomain = city.domain[/city-\d+/]
      visit url_for_subdomain subdomain, "/" 
    end

    it { should have_link workshop.name }

  end



end
