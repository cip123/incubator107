ActiveAdmin.register City do
  menu parent: "Settings"

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :domain

    actions
  end

  show do |city|
    panel 'Details' do
      attributes_table_for city do
        row :name
        row :domain
        row :facebook
        row :email
        row :default_location
        row :mailing_list
        row :google_analytics_code
      end
    end

    panel 'Default donation' do
      attributes_table_for city do
        row :donation_text do
          raw city.donation_text
        end 
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :domain
      f.input :facebook
      f.input :email
      f.input :default_location
      f.input :mailing_list
      f.input :google_analytics_code
     end
     
     f.inputs "Default donation" do
       f.input :donation_text, :label => false, :as => :text, :input_html => { class: "tinymce-light"}
     end

    f.actions
  end


  filter :translations
  filter :domain

  permit_params :name, :domain, :donation_text, :facebook, :email, :default_location_id, :mailing_list_id

end
