ActiveAdmin.register News do

  filter :translations_title, as: :string, label: "Title" 
  filter :city
  filter :published
  filter :release_date

  index do
    selectable_column
    id_column
    column :title, sortable: 'news_translations.title'
    column :published
    column :city
    column :created_at
    actions
  end

  show do |news|
    attributes_table do
      row :title
      row :content do
        raw news.content
      end 
      row :city
      row :published

      row :image do |news| 
        image_tag(news.image.url)
      end
      row :release_date
    end
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :title
      f.input :published, :as => :radio, :label => "Publish", :collection => [["Yes", true], ["No", false]]
      f.input :image, :as => :file
      f.input :release_date, :as => :string, :input_html => { class: "datepicker", size: 12, max: 10, :value =>  news.release_date.nil? ? "" : news.release_date.strftime("%Y-%m-%d") }     
      f.input :city
    end
    f.inputs "Content" do  
      f.input :content, :label => false, :as => :text, :input_html => { class: "tinymce"}
    end

    f.actions
  end


  controller do

    def scoped_collection 
      end_of_association_chain.includes(:translations => [])
    end

  end
# sidebar "Associations", only: [:show, :edit] do
#   ul do
#     li link_to "Subscribers", admin_mailing_list_subscribers_path(mailing_list.id)
#   end
# end

# See permitted parameters documentation:
# https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :published, :release_date, :content, :city_id, :image


#
# or
#
# permit_params do
#  permitted = [:permitted, :attributes]
#  permitted << :other if resource.something?
#  permitted
# end

end
