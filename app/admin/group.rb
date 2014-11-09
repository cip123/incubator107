ActiveAdmin.register Group do
  menu parent: "Settings"
  config.filters = false

  index do
    selectable_column
    id_column
    column :name, sortable: 'group_translations_name'
    column :index
    column :active

    actions
  end

  show do |group|
    attributes_table do
      row :name
      row :image do |news| 
        image_tag(group.image.url)
      end
      row :index
      row :active
    end
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :image, as: :file
      f.input :index
      f.input :active
     end
     
    f.actions
  end

  permit_params :name, :image, :index, :active

  controller do

    def scoped_collection
      end_of_association_chain.includes(translations: [])
    end

  end

end
