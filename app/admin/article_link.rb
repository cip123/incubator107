ActiveAdmin.register ArticleLink do
  menu parent: "Settings"
  filter :article_translations_title, as: :string, label: "Article Title"
  filter :alias, as: :select, collection: proc { ArticleLink.aliases }
  filter :city
  filter :created_at

  index do
    selectable_column
    id_column
    column :alias
    column :article, sortable: 'article_translations.title'
    column :city
    column :created_at

    actions
  end


  show :title => :alias do
    attributes_table do
      row :alias
      row :article
      row :city
    end
  end

  form do |f|
    f.inputs do
      f.input :alias, as: :select, collection:  ArticleLink.aliases.map{ |a| "#{a[0]}" }
      f.input :article
      f.input :city
    end
     
    f.actions
  end

  permit_params :alias, :article_id, :city_id

 controller do

    def scoped_collection 
      end_of_association_chain.includes(:article => [translations: []])
    end
 end 

end



