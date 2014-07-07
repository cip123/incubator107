require 'spec_helper'

describe "contact page" do


  before  do
    location = FactoryGirl.create(:location) 
    city  = FactoryGirl.create(:city_with_links, location_id: location.id) 
    5.times do |n|
      FactoryGirl.create(:contact_person, city_id: city.id)
    end
    visit url_for_subdomain "cluj", "/contact"
  end

  it "should have location information" do
    expect(page).to have_content "Location_1"
    pattern = ""
    5.times do |n|
      pattern += "contact #{n+1}.*" 
      pattern += "title #{n+1}.*" 
      pattern += "about #{n+1}.*"
    end
    puts pattern
    expect(page.body).to match /#{pattern}/m
  end

end
