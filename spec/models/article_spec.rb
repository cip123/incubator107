require 'spec_helper'

describe Article do

  let(:article) { FactoryGirl.create(:article) }

  subject { article }

  it { should respond_to(:content) }
  it { should respond_to(:title) }
  describe "with blank text" do
    before { article.content = " " }
    it { should_not be_valid }
  end


end

