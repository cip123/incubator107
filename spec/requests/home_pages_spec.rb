require "spec_helper"

describe "Home pages" do

  subject { page }

  describe "city page" do

    let (:city) { FactoryGirl.create(:city_with_articles) }
    before do
      subdomain = city.domain[/city-\d+/]
      visit url_for_subdomain subdomain, '/' 
    end

    it { should have_title "incubator107 "+city.name }
    it { should_not have_link "Sign in" }
    it { should_not have_link "Home" }
    it { should have_link "Cine suntem" }
    it { should have_link "Ateliere" }
    it { should have_link 'Contact' }

    describe "when visiting the about page" do

        before do
          click_link 'Cine suntem'
        end

        it { should have_title "Cine suntem" }
    end
  end  
end
