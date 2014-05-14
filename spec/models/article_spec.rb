require 'spec_helper'

describe Article do

  let(:user) { FactoryGirl.create(:user) }
  before do 
    @article = user.articles.build( content:  "Lorem ipsum")
  end

  subject { @article }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }

  it { should respond_to(:user) }
  its(:user) { should eq user }

  describe "when user_id is not present" do 
    before { @article.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @article.content = " " }
    it { should_not be_valid }
  end


end

