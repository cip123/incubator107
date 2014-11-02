ActiveAdmin.register City do
  menu parent: "Settings"

  filter :translations_name, as: :string, label: "Name"
  filter :domain
  filter :active


  index do
    selectable_column
    id_column
    column :name, sortable: "city_translations.name"
    column :email
    column :domain
    column :active

    actions
  end

  show do |city|
    panel 'Details' do
      attributes_table_for city do
        row :name
        row :domain
        row :email
        row :google_analytics_code        
        row :default_event_location
        row :active
      end
    end

    panel 'Default Donation' do
      attributes_table_for city do
        row :default_donation do
          raw city.default_donation
        end 
       end
    end

    panel 'Default Whereabouts' do
      attributes_table_for city do
         row :default_whereabouts do
          raw city.default_whereabouts
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
        row :mailchimp_newsletter_list_id
        row :mailchimp_workshop_list_id
        row :mailchimp_workshop_groups_id
      end
    end

  end

  permit_params :name, :domain, :default_donation, :default_whereabouts, :facebook_page_id, :email, :default_event_location_id, 
    :google_analytics_code, :mailchimp_key, :mailchimp_newsletter_list_id, :mailchimp_workshop_list_id, :mailchimp_workshop_groups_id, :active


  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :domain
      f.input :email
      f.input :google_analytics_code
      f.input :default_event_location
      f.input :active, :as => :radio, :label => "Active", :collection => [["Yes", true], ["No", false]]
    end
     
    f.inputs "Default Donation" do
      f.input :default_donation, :label => false, :as => :text, :input_html => { class: "tinymce-light"}
    end

    f.inputs "Default Whereabouts" do
      f.input :default_whereabouts, :label => false, :as => :text, :input_html => { class: "tinymce-light"}
    end


    f.inputs 'facebook' do
      f.input :facebook_page_id
    end

    f.inputs "Mailchimp" do
      f.input :mailchimp_key
      f.input :mailchimp_newsletter_list_id
      f.input :mailchimp_workshop_list_id
      f.input :mailchimp_workshop_groups_id
    end

    f.actions
  end

  controller do
    def scoped_collection
      end_of_association_chain.includes(translations: [])
    end

  end

end
