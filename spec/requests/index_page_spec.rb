require 'spec_helper'

describe "root page" do

  before  do 
    10.times do |n|
      FactoryGirl.create(:city, domain: "domain#{n}") 
    end 
    visit "http://lvh.me:3000"
  end

  describe "index" do

    it "should have all the cities" do

      expect(page).to have_title("Incubator107")
      
      10.times.each do |n|
        expect(page).to have_content("City #{n+1}") 
      end 
    end
  end 
end
