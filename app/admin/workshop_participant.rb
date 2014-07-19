ActiveAdmin.register WorkshopParticipant do

  belongs_to :workshop

  index do
    selectable_column
    id_column
    column :participant
    column :reason
    column :display

    actions
  end

  form do |f|
    f.inputs  do
      f.input :participant_id, :label => 'Participant', :as => :select, :collection => Participant.all.map{|p| ["#{p.email}, #{p.name}", p.id]}
      f.input :reason
      f.input :display
     end
     
    f.actions
  end


  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :workshop_id, :participant_id, :display, :reason
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
