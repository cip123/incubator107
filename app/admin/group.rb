ActiveAdmin.register Group do
  menu parent: "Settings"
  config.filters = false

  index do
    selectable_column
    id_column
    column :name, sortable: 'group_translations_name'

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

  permit_params :name

  controller do

    def scoped_collection
      end_of_association_chain.includes(translations: [])
    end

  end

end
