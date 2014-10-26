ActiveAdmin.register Article do

  filter :translations_title, as: :string, label: "Title"
  filter :city
  filter :published

  index do
    selectable_column
    id_column
    column :title, sortable: 'article_translations.title'
    column :published
    # sortable by city is not possible at the moment
    # because we should do a double nested association with city_translation
    column :city
    column :created_at

    actions
  end


  show do |article|
      attributes_table do
        row :title
        row :content do
          raw article.content
        end 
        row :published
        row :city
      end
  end

  permit_params :title, :text, :content, :published, :city_id

  form do |f|
    f.inputs "Article Details" do
      f.input :title
      f.input :published, :as => :radio, :label => "Publish", :collection => [["Yes", true], ["No", false]]
      f.input :city
     end
     
    f.inputs "Content" do  
      f.input :content, :label => false, :as => :text, :input_html => { class: "tinymce"}
    end

    f.actions
  end

  # currently there is a Chrome / Safari bug 
  controller do

    def scoped_collection 
      end_of_association_chain.includes(:translations => [])
    end
    
    def create
      super do |format|
        redirect_to admin_articles_path and return if resource.valid?
      end
    end
    
    def update
      super do |format|
        redirect_to admin_articles_path and return if resource.valid?
      end
    end
  end


  

end
