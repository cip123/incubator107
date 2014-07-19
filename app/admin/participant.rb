ActiveAdmin.register Participant do
 
  form do |f|
    f.inputs "Participant details" do
      f.input :name
      f.input :email
      f.input :phone
      f.input :verified
    end

    f.actions
  end


  controller do
    def new
      
      puts params.inspect
      @participant = Participant.new()
      @participant.workshop_participants.build(:workshop_id => params[:workshop_id])
      super
    end 
  end


  filter :name
  filter :email
  filter :phone
  filter :verified
  filter :created_at
  filter :updated_at



  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  #permit_params :name, :email, :phone, :verified
  permit_params :name, :email, :phone, :verified, :_destroy, workshop_participants_attributes: [:id, :reason, :workshop_id, :_destroy]
  
end
