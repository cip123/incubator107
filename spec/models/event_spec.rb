require 'spec_helper'

describe Event do

  let!(:event) { FactoryGirl.create(:event) }

  it " should respond to attributes" do
    
    expect(event).to respond_to :start_date

  end

  it " should not be valid without required attributes" do
    
    event.duration = nil
    expect(event).not_to be_valid

    event.start_date = nil
    expect(event).not_to be_valid

  end

    

end
