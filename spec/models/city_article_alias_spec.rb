require 'spec_helper'

describe CityArticleAlias do

  before do
    @article_alias = CityArticleAlias.new(name: 'about', article_id: 3, city_id: 4)
  end

   subject { @article_alias }
  it { should respond_to :article_id }
  it { should respond_to :city_id }
  it { should respond_to :name }
  it { should respond_to :locale }


  describe "with empty values" do
    before do
     @article_alias = CityArticleAlias.new(name: 'about' )
    end

    it { should_not be_valid }
  end

  describe "with invalid article id" do

    before do
      @article_alias = CityArticleAlias.new(name: 'about', article_id: 3, city_id: 2 )
    end
   it { should_not be_valid }
#    puts @articles_city.inspect
#    @articles_city.article_id = 3
  end



end

