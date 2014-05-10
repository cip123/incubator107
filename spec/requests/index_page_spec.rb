require 'spec_helper'

describe "Home Page" do

  subject { page }

  before (:all) do 
    10.times { FactoryGirl.create(:city) }
  end

  before(:each) { visit root_path }
  after(:all) { City.delete_all }
  describe "index" do

    it { should have_title('Incubator107') }
    it { should have_content('City 1') }
    it { should have_content('City 2') }
    it { should have_content('City 3') }
    it { should have_content('City 4') }
    it { should have_content('City 5') }
    it { should have_content('City 6') }
    it { should have_content('City 7') }
    it { should have_content('City 8') }
    it { should have_content('City 9') }
    it { should have_content('City 10') }
  end
end
