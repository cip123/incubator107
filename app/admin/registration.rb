ActiveAdmin.register Registration do

  
  filter :workshop_translations_name, as: :string, label: "Workshop Name"
  filter :person_name, as: :string, label: "Person Name"
  filter :workshop_city_id, as: :select, label: "City", collection: proc { City.all }
  filter :event_start_date, as: :date_range

  index do
    selectable_column
    id_column
    column :person, sortable: "people.name"
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

  show do |registration|
      attributes_table do
        row :person_id
        row :event_id
        row :workshop do |registration|
          link_to(registration.event.workshop.name, admin_workshop_path(registration.event.workshop))
        end
        row :reason
      end
  end


  form do |f|
    f.inputs  do
      f.input :person_id, :label => 'Person', :as => :select, :collection => Person.order(:email).map{|p| ["#{p.email}, #{p.name}", p.id]}
      f.input :event, :label => 'Event', :as => :select, :collection => Event.includes(workshop: [ translations: []]).order("workshop_translations.name").map{|e| ["#{e.workshop.name} - #{e.description}", e.id]}
      f.input :reason
     end
     
    f.actions
  end


  controller do
    def scoped_collection
      end_of_association_chain.includes(person: [], workshop: [ translations: [] ], event: [] )
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
