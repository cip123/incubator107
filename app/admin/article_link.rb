ActiveAdmin.register ArticleLink do
  belongs_to :city

  show :title => :alias do
    attributes_table do
      row :alias
      row :article
    end
  end

  form do |f|
    f.inputs do
      f.input :alias
      f.input :article
    end
     
    f.actions
  end

  index do
    selectable_column
    id_column
    column :alias
    column :article
    column :created_at

    actions
  end

  filter :article
  filter :created_at

  permit_params :alias, :article

end



