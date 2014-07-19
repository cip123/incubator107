ActiveAdmin.register City do

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :domain

    actions
  end

  sidebar "Associations", only: [:show, :edit] do
    ul do
      li link_to "Pages", admin_city_article_links_path(city.id)
      li link_to "Contact People", admin_city_contact_people_path(city.id)
      li link_to "Locations", admin_city_locations_path(city.id)
      li link_to "News", admin_city_news_index_path(city.id)
    end
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
