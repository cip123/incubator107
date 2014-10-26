ActiveAdmin.register WorkshopRequest do


  filter :workshop_translations_name, as: :string, label: "Workshop Name"
  filter :person_name, as: :string, label: "Person Name"

  index do
    selectable_column
    id_column
    column :person, :sortable => "people.id" do |workshop_request| 
      link_to(workshop_request.person.name, admin_person_path(workshop_request.person))
    end

    column :workshop, :sortable => "workshops.id" do |workshop_request|
      link_to(workshop_request.workshop.name, admin_workshop_path(workshop_request.workshop))
    end
    column :updated_at
    # column :workshop do |registration|
    #   registration.event.workshop.name
    # end

    actions
  end

  permit_params :workshop_id, :person_id, :reason

  form do |f|
    f.inputs  do
      f.input :person_id, :label => 'Person', :as => :select, :collection => Person.all.map{|p| ["#{p.email}, #{p.name}", p.id]}
      f.input :workshop_id, :label => 'Workshop', :as => :select, :collection => Workshop.all
      f.input :reason
    end

    f.actions
  end

  filter "workshop"
  filter :updated_at

  controller do
    def scoped_collection
      end_of_association_chain.includes(:person => [], :workshop => [ :translations => [] ] )
    end
  end
# See permitted parameters documentation:
# https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
#
# or
#
# permit_params do
#  permitted = [:permitted, :attributes]
#  permitted << :other if resource.something?
#  permitted
# end

end
