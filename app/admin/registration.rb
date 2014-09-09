ActiveAdmin.register Registration do

  index do
    selectable_column
    id_column
    column :person
    column :event, :sortable => "events.start_date" do |registration|
      registration.event.start_date.strftime('%F %R')  
    end
    column :workshop, :sortable => "workshops.id" do |registration|
        link_to(registration.event.workshop.name, admin_workshop_path(registration.event.workshop))
    end
    # column :workshop do |registration|
    #   registration.event.workshop.name
    # end

    actions
  end

  form do |f|
    f.inputs  do
      f.input :person_id, :label => 'Person', :as => :select, :collection => Person.all.map{|p| ["#{p.email}, #{p.name}", p.id]}
      f.input :reason
     end
     
    f.actions
  end

  filter "event.start_date"
  filter "workshop"

  controller do
    def scoped_collection
      Registration.joins(:event => [ :workshop] )
    end
  end
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :event_id, :person_id, :reason
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
