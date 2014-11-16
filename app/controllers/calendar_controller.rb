class CalendarController < SubdomainController

	def show

    @page_handle = "calendar"


	end

  respond_to do |format|
    format.js
  end
end
