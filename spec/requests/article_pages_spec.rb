require 'spec_helper'

describe "Article pages" do

  subject { page }

  describe "display" do

    let!(:city) { FactoryGirl.create(:city_with_links) }
    let(:article) { FactoryGirl.create(:article) }

    before do
      visit url_for_subdomain "cluj", article_path(article)
    end

    it { should have_title("Lorem") }
    it { should have_content("Pace pentru fratii mei iubire totdeauna") }

  end
end
