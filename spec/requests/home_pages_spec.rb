require "spec_helper"

describe "Home pages" do

  subject { page }

  I18n.available_locales.each do |locale| 
    puts locale
    describe "city page" do

      let (:city) { FactoryGirl.create(:city_with_articles) }

      describe "with #{locale} locale" do
        before do
          subdomain = city.domain[/city-\d+/]
          visit url_for_subdomain subdomain, '/'+locale.to_s+'/' 
        end

        it { should have_title "incubator107 "+city.name }
        it { should_not have_link "Sign in" }
        it { should_not have_link "Home" }
        it { should have_link I18n.t(:who_are_we) }
        it { should have_link I18n.t(:workshops)}
        it { should have_link I18n.t(:contact) }

        describe "when visiting the about page" do
          before { click_link I18n.t(:who_are_we) } 

          it { should have_title I18n.t(:what_is_incubator107) }
        end
      end
    end  
  end
end
