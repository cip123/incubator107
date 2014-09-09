ActiveAdmin.register City do
  menu parent: "Settings"

  after_create do |city|

    Group.all.each do |group|
      CityGroup.create( city: city, group: group)
    end

  end

  after_destroy do |city|
    CityGroup.where( :city => city).destroy_all
  end

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
        row :email
        row :default_location
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

    panel 'facebook' do
      attributes_table_for city do
        row :facebook_page_id
      end
    end

    panel 'mailchimp' do
      attributes_table_for city do
        row :mailchimp_key
        row :newsletter_list_id
        row :workshop_list_id
        row :workshop_groups_id
      end
    end

  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :domain
      f.input :email
      f.input :default_location
      f.input :google_analytics_code
    end
     
    f.inputs "Default donation" do
      f.input :donation_text, :label => false, :as => :text, :input_html => { class: "tinymce-light"}
    end

    f.inputs 'facebook' do
      f.input :facebook_page_id
    end

    f.inputs "Mailchimp" do
      f.input :mailchimp_key
      f.input :newsletter_list_id
      f.input :workshop_list_id
      f.input :workshop_groups_id
    end



    f.actions
  end


  filter :translations
  filter :domain

  permit_params :name, :domain, :donation_text, :facebook_page_id, :email, :default_location_id, 
    :google_analytics_code, :mailchimp_key, :newsletter_list_id, :workshop_list_id, :workshop_groups_id    

end
