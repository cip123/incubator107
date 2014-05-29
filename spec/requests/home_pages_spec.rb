require "spec_helper"

describe "Home pages" do

  subject { page }

  describe " navigation bar " do
    I18n.available_locales.each do |locale|

      describe "with #{locale} locale" do
        let!(:city) { FactoryGirl.create(:city_with_links) }

        before do
          
          visit url_for_subdomain :cluj, "/#{locale}/"
          @locale_prefix = (locale != I18n.default_locale ? "/#{locale}": "" )
        end

        it { should have_title "incubator107 #{city.name} " }
        it { should_not have_link "Sign in" }
        it { should_not have_link "Home" }
        #puts page.find_link(I18n.t(:who_are_we)).inspect
        it { should have_link ( I18n.t(:who_are_we)), :href => @locale_prefix + article_path(:id => city.about_article_id) }
        it { should have_link I18n.t(:workshops)}
        it { should have_link I18n.t(:contact) }

      end
    end
  end

  describe "side bar" do
  let!(:city) { FactoryGirl.create(:city_with_links, name: 'cluj') }
    describe "when beginning of the month" do
      before do
        t = Time.now
        Time.stub(:now) { t.change(:day => 15) }        
        visit url_for_subdomain :cluj, "/"
      end

      it { should have_link "active workshop" }
      it { should_not have_link "inactive workshop" }
      it { should_not have_link "next month workshop" }
      it { should have_content I18n.t(:this_month) }
      it { should_not have_content I18n.t(:next_month) }
      it { should_not have_link "next month workshop" }
    end

    describe "when at end of the month" do
      before do
        t = Time.now
        Time.stub(:now) { t.change(:day => 25) }       
        visit url_for_subdomain :cluj, "/"
      end

      it { should have_link "active workshop" }
      it { should_not have_link "inactive workshop" }
      it { should have_link "next month workshop" }
      it { should have_content I18n.t(:this_month) }
      it { should have_content I18n.t(:next_month) }
    end
  end

end
