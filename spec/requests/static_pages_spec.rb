require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home Page" do 

    it "should have the content 'Incubator107'" do
      visit '/static_pages/home'
      expect(page).to have_content('incubator107')
    end
  end


  describe "Subdomain login ( this was added on rpi)" do

    before { visit url_for_subdomain 'bucuresti', '/' }

    it { should have_content('although') }

  end

end
