class ContactController < SubdomainController
  def show
    @location = Location.find(@city.default_event_location_id)
    @contact_people = @city.contact_persons
  end
end
