class WorkshopRequestMailer < ActionMailer::Base
  
  default from: "inscrieri@incubator107.com"

  def notify(params ={})

    @workshop = params[:workshop]
    @count = params[:workshop]
    
    mail(to: "noi@incubator107.com", subject: "#{@workshop.name} requested")
  end

end
