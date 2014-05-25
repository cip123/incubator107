require "spec_helper"

describe "Home pages" do

  subject { page }

  describe " navigation bar " do
    I18n.available_locales.each do |locale| 

      let (:city) { FactoryGirl.create(:city_with_links, name: 'cluj') }

      describe "with #{locale} locale" do
        before do
          subdomain = city.domain[/city-\d+/]
          visit url_for_subdomain subdomain, "/#{locale}/" 
          @locale_prefix = (locale != I18n.default_locale ? "/#{locale}": "" ) 
        puts city.about_article_id
        end

        it { should have_title "incubator107 #{city.name} " }
        it { should_not have_link "Sign in" }
        it { should_not have_link "Home" }
        #puts page.find_link(I18n.t(:who_are_we)).inspect
        it { should have_link ( I18n.t(:who_are_we)), :href => @locale_prefix + article_path(:id => city.about_article_id) } 
        it { should have_link I18n.t(:workshops)}
        it { should have_link I18n.t(:contact) }

      end
    end  
  end

  describe "side bar" do
    let (:city) { FactoryGirl.create(:city_with_links) }

    before do 
      subdomain = city.domain[/city-\d+/]
      visit url_for_subdomain subdomain, "/" 
    end

    it { should have_link city.workshops.first.name }

  end
end
