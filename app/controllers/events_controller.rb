class EventsController < ApplicationController

  def index
    
    city = City.find_by_domain(request.subdomains.first.to_s)
    events = city.events.current(Time.at(params[:start].to_i)..Time.at(params[:end].to_i))

    respond_to do |format|
      format.html
      format.json do
        render :json => custom_json_for(events)
      end
    end
  end
  private
  def custom_json_for(entry)
    list = entry.map do |entry|
      { :id => entry[0],
        :start => entry[2],
        :allDay => false,
        :title => entry[1]
      }
    end
    list.to_json
  end
end
