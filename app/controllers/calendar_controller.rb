class CalendarController < SubdomainController

	def show
    #puts @city.workshops.first.events
	end

  respond_to do |format|
    format.js
  end
end
