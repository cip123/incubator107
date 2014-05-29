require 'spec_helper'

describe City do

  let(:city) { FactoryGirl.create(:city) }


  it "should respond to attributes" do
    expect(city).to respond_to(:name)
    expect(city).to respond_to(:email)

  end

  it "should not be valid with wrong email" do
    city.email = " "
    expect(city).not_to be_valid
		
		city.email = " nu-e@un_email.ro"
    expect(city).not_to be_valid
  end

  it "should not be valid without name" do
    city.name = " "
    expect(city).not_to be_valid
  end

  it "should not be valid without domain" do
    city.domain = " "
    expect(city).not_to be_valid
  end

  it "should not be valid without donation" do
    city.donation = -20
    expect(city).not_to be_valid
    city.donation = nil
    expect(city).not_to be_valid
  end

  it "should not be valid without mailing list" do
    city.mailing_list_id = nil
    expect(city).not_to be_valid
  end


end
