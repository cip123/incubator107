require 'spec_helper'

describe Location do

  let (:location) { FactoryGirl.create(:location) }
 
  subject { location }


  it { should respond_to(:name) }
  it { should respond_to(:city) }
end
