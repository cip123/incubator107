ActiveAdmin.register ArticleLink do
  menu parent: "Settings"

  show :title => :alias do
    attributes_table do
      row :alias
      row :article
      row :city
    end
  end

  form do |f|
    f.inputs do
      f.input :alias
      f.input :article
      f.input :city
    end
     
    f.actions
  end

  index do
    selectable_column
    id_column
    column :alias
    column :article
    column :city
    column :created_at

    actions
  end

  filter :article
  filter :city
  filter :created_at

  permit_params :alias, :article, :city_id

end



