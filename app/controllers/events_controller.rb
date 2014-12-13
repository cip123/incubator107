class EventsController < ApplicationController

  def index
    puts params
    city = City.find_by_domain(request.subdomains.first.to_s)
    events = city.events.current(Date.parse(params[:start])..Date.parse(params[:end]))
    puts events.inspect
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
      { :id => entry[4],
        :start => entry[2],
        :end => entry[2].advance(:minutes => entry[3].to_i),
        :allDay => false,
        :url => workshop_path(entry[4]),
        :title => entry[1]
      }
    end
    list.to_json
  end
end
