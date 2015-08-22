ActiveAdmin.register Partner do

  filter :name
  filter :city
  filter :published

  index do
    selectable_column
    id_column
    column :name
    column :published
    column :index
    column :city
    actions
  end

  show do |partner|
    attributes_table do
      row :name
      row :description do
        raw partner.description
      end 
      row :city
      row :index
      row :published

      row :image do |partner| 
        image_tag(partner.image.url)
      end
      row :category
    end
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :published, :as => :radio, :label => "Publish", :collection => [["Yes", true], ["No", false]]
      f.input :index
      f.input :image, :as => :file
      f.input :category, as: :select, collection:  Partner.categories.map{ |c| "#{c[0]}" }
      f.input :city
    end
    f.inputs "Description" do  
      f.input :description, :label => false, :as => :text, :input_html => { class: "tinymce"}
    end

    f.actions
  end


  controller do

    def scoped_collection 
      end_of_association_chain.includes(:translations => [])
    end

  end

  permit_params :name, :published, :index, :description, :category, :city_id, :image


end
