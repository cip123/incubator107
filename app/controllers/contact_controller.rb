class ContactController < SubdomainController
  def show
    @location = Location.find(@city.default_event_location_id) unless @city.default_event_location_id.nil?
    @contact_people = @city.contact_persons.order(:index)
  end
end
