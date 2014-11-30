ActiveAdmin.register Location do

  index do
    selectable_column
    id_column
    column :name, sortable: 'location_translations.name'
    column :address, sortable: 'location_translations.address'
    column :city

    actions
  end  


  show do |location|
      attributes_table do
        row :name
        row :address
        row :description do
          raw location.description
        end
        row :city
        row :url
        row :latitude
        row :longitude
      end
  end

  form do |f|
    f.inputs "Location Details" do
      f.input :name
      f.input :address,:input_html => { rows: 2, cols: 40 }
      f.input :url
      f.input :city
      f.input :latitude
      f.input :longitude
     end
     
    f.inputs "description" do  
      f.input :description, :label => false, :as => :text, :input_html => { class: "tinymce-light"}
    end

    f.actions
  end

  controller do
    def scoped_collection 
      end_of_association_chain.includes(:translations => [])
    end
  end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :name, :address, :description, :url, :city_id, :latitude, :longitude
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  filter :city 
  filter :translations_name, as: :string, label: "Name"
 
  filter :description
  filter :created_at


end
