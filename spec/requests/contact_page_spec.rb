require 'spec_helper'

describe "contact page" do

  before  do    
    @location = FactoryGirl.create(:location)
    city  = FactoryGirl.create(:city_with_links, default_event_location_id: @location.id) 
    5.times do |n|
      FactoryGirl.create(:contact_person, city_id: city.id)
    end
    visit url_for_subdomain "cluj", "/contact"
  end

  it "should have location information" do    
    expect(page).to have_content @location.description
    pattern = ""
    5.times do |n|
      pattern += "CONTACT #{n+1}.*" 
      pattern += "TITLE #{n+1}.*" 
      pattern += "about #{n+1}.*"
    end
    expect(page.body).to match /#{pattern}/m
  end

end
