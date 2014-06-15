require 'spec_helper'

describe Event do
  describe "model" do
    let(:event) { FactoryGirl.create(:event) } 

    after :all do
      Event.delete_all
    end

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
  describe "events query for published workshops" do
    before do
      FactoryGirl.create(:event) 
      FactoryGirl.create(:workshop)
    end
    it "should return events with workshops" do
      events = Event.all
      expect(events.first).to respond_to :workshop 
    end
  end


  describe "events in a certain period" do
    
    let!(:city) { FactoryGirl.create(:city_with_links) }

    before do 
      workshop = FactoryGirl.create(:workshop)
      unpublished_workshop = FactoryGirl.create(:workshop, :published => false)
      FactoryGirl.create(:event, :start_date => DateTime.now)
      FactoryGirl.create(:event, :start_date => 1.month.ago, :workshop_id => workshop.id)
      FactoryGirl.create(:event, :start_date => 1.month.from_now, :workshop_id => unpublished_workshop.id)
      FactoryGirl.create(:event, :start_date => 1.month.from_now)
    end

    after :all do
      Event.delete_all
    end
    it "should select only the events from this month" do
      current_month_events =city.events.current(Date.today..2.months.from_now)
      assert_equal 2, current_month_events.count
    end
  end


end
