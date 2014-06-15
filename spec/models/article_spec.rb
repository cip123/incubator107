require 'spec_helper'

describe Article do

  let(:article) { FactoryGirl.create(:article) }

  subject { article }

  it { should respond_to(:text) }
  it { should respond_to(:title) }
  describe "with blank text" do
    before { article.text = " " }
    it { should_not be_valid }
  end


end

