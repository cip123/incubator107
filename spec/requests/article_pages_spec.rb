require 'spec_helper'

describe "Article pages" do

  subject { page }

  describe "display" do

    let(:article) { FactoryGirl.create(:article) }

    before do
      visit article_path(article)
    end

    it { should have_title(article.name) }
    it { should have_content(article.content) }

  end
end
