require 'spec_helper'

describe "StaticPages" do

  describe "Home Page" do 

    it "should have the content 'Incubator107'" do
      visit '/static_pages/home'
      expect(page).to have_content('incubator107')
    end
  end


  describe "Subdomain" do

    it "should point to a specific page" do
      visit url_for_subdomain 'bucuresti', '/'
      expect(page).to have_content('although')
    end 
  end
end
