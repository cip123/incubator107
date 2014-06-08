require 'spec_helper'

describe Workshop do

  let(:workshop) { FactoryGirl.create(:workshop) }

  it "should not be valid without city id" do
    workshop.city_id = nil
    expect(workshop).not_to be_valid
  end

  it "should respond to attributes" do
    expect(workshop).to respond_to(:name)
  end

  it "should order the events" do
   assert workshop.events.each_cons(2).all?{|i,j| i.start_date >= j.start_date} 
  end
end
