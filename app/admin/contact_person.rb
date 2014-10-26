ActiveAdmin.register ContactPerson do
  menu parent: "Settings"  

  show do
    attributes_table do
      row :name
      row :phone
      row :email
      row :title
      row :about
      row :team
      row :index
      row :city
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :phone
      f.input :email
      f.input :title
      f.input :about
      f.input :team
      f.input :index
      f.input :city
    end
     
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :title, sortable: "contact_person_translations.title"
    column :index
    column :city
    actions
  end

  filter :city
  filter :name

  permit_params :name, :phone, :email, :title, :about, :team, :index, :city_id
  
  controller do

    def scoped_collection
      end_of_association_chain.includes( translations: [])
    end

  end

end
