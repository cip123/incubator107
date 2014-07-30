ActiveAdmin.register Location do

  index do
    selectable_column
    id_column
    column :name
    column :address
    column :city

    actions
  end  


  show do |article|
      attributes_table do
        row :name
        row :address
        row :description do
          raw location.description
        end
        row :city
        row :url
      end
  end

  form do |f|
    f.inputs "Location Details" do
      f.input :name
      f.input :address,:input_html => { rows: 2, cols: 40 }
      f.input :url
      f.input :city
     end
     
    f.inputs "description" do  
      f.input :description, :label => false, :as => :text, :input_html => { class: "tinymce-light"}
    end

    f.actions
  end

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :name, :address, :description, :url, :city_id
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  filter :city
  filter :name
  filter :name
  filter :created_at


end
