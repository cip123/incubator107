ActiveAdmin.register News do

  index do
    selectable_column
    id_column
    column :title
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
        row :published
        row :release_date
      end
  end

  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :published, :as => :radio, :label => "Publish", :collection => [["Yes", true], ["No", false]]
      f.input :release_date, :as => :string, :input_html => { class: "datepicker", size: 12, max: 10, :value =>  news.release_date.nil? ? "" : news.release_date.strftime("%Y-%m-%d") }     
     end
     
    f.inputs "Content" do  
      f.input :content, :label => false, :as => :text, :input_html => { class: "tinymce"}
    end

    f.actions
  end


  # sidebar "Associations", only: [:show, :edit] do
  #   ul do
  #     li link_to "Subscribers", admin_mailing_list_subscribers_path(mailing_list.id)
  #   end
  # end

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title, :published, :release_date, :content, :city_id
  
  filter :published
  filter :release_date

  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
