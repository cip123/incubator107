ActiveAdmin.register Group do
  menu parent: "Settings"

  index do
    selectable_column
    id_column
    column :name

    actions
  end

  show do |group|
    attributes_table do
      row :name
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
     end
     
    f.actions
  end


  filter :translations
  filter :domain

  permit_params :name

end