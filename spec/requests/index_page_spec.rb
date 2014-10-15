require 'spec_helper'

describe "root page" do



  before  do 
    
    10.times do |n|
      FactoryGirl.create(:city, domain: "domain#{n}") 
    end 
    visit "http://lvh.me:3001"
  end

  describe "index" do

    it "should have all the cities" do

      expect(page).to have_title("Incubator107")
      
      City.all.each do |city|
        expect(page).to have_content(city.name.upcase) 
      end 
    end
  end 
end
