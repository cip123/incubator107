ActiveAdmin.register Article do

 
  
  index do
    selectable_column
    id_column
    column :title
    column :city
    column :published
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


  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  permit_params :title, :text, :published, :city_id
  
  #TODO ransacker does not know globalize3
  filter "translations.title"
  filter :city
  filter :published

end
