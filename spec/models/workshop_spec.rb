require 'spec_helper'

describe Workshop do

  let (:city) { FactoryGirl.create(:city_with_links) }

  describe "attributes" do
    let(:workshop) { FactoryGirl.create(:workshop) }

    it "should not be valid without city id" do
      workshop.city_id = nil
      expect(workshop).not_to be_valid
    end

    it "should respond to attributes" do
      expect(workshop).to respond_to(:name)
    end

    it "should order the events" do
      assert workshop.events.each_cons(2).all?{|i,j| i.start_date >= j.start_date} 
    end
  end
  describe "querying" do

      before do
        t = DateTime.now
        DateTime.stub(:now) { t.change(:day => 25) }        
        FactoryGirl.create(:workshop_with_events, published: false)
        FactoryGirl.create(:workshop_with_events, name: "atelier_luna_asta")
        FactoryGirl.create(:workshop_with_events, city_id: 2)
      end

      it "should return correct workshop names when at beginning of the month" do
        time_range = Date.today.at_beginning_of_month..Date.today.end_of_month
        this_month_workshops, next_month_workshops = city.workshops.published time_range 
        
        assert_equal 0, next_month_workshops.count
        assert_equal 1, this_month_workshops.count
        assert_equal "atelier_luna_asta", this_month_workshops.first[1] 
      end

      it "should return correct workshop names when at end of the month" do
        time_range = Date.today.at_beginning_of_month..Date.today.end_of_month.next_month
        this_month_workshops, next_month_workshops = city.workshops.published time_range 
        
        assert_equal 1, next_month_workshops.count
        assert_equal 1, this_month_workshops.count
        assert_equal "atelier_luna_asta", this_month_workshops.first[1] 
      end
    end
end
