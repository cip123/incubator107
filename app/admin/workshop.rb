ActiveAdmin.register Workshop do

  filter :translations_name, as: :string, label: "Name"
  filter :group
  filter :city
  filter :release_date
  filter :published

  index do
    selectable_column
    id_column

    column :name, :sortable => "workshop_translations.name"
    column :city   
    column :published    

    actions
  end


  sidebar "Meetings", only: [:show, :edit] do
    ul do
      li link_to "Events", admin_workshop_events_path( workshop)
    end
  end

  form do |f|
    f.inputs "Workshop Details" do
      f.input :name
      f.input :facebook_album_id, :label => "Facebook album"
      f.input :city
      f.input :group
      f.input :published, :as => :radio, :label => "Publish", :collection => [["Yes", true], ["No", false]]
      f.input :registrations_enabled, :as => :radio, :label => "Registrations enabled", :collection => [["Yes", true], ["No", false]]
      f.input :release_date, :as => :string, :input_html => { class: "datepicker", size: 12, max: 10, :value =>  workshop.release_date.nil? ? "" : workshop.release_date.strftime("%Y-%m-%d") } 
      f.input :should_send_notification, :as => :radio, :label => "Send notification", :collection => [["Yes", true], ["No", false]]      
    end

    f.inputs "Description" do        
      f.input :description, :label => false, :as => :text, :input_html => { class: "tinymce" } 
    end

    f.inputs "With whom ?" do  
      f.input :with_whom, :label => false, :as => :text, :input_html => { class: "tinymce" } 
    end

    f.inputs "Bring along" do      
      f.input :bring_along, :label => false, :as => :text, :input_html => { class: "tinymce-light" } 
    end

    f.inputs "Whereabouts" do  
      f.input :whereabouts, :label => false, :as => :text, :input_html => { class: "tinymce-light" } 
    end

    f.inputs "Donation Text" do  
      f.input  :requires_donation, :as => :radio, :label => "Requires donation", :collection => [["Yes", true], ["No", false]] 
      f.input :donation, :label => false, :as => :text, :input_html => { class: "tinymce-light" } 
    end

    f.actions
  end


  show do |workshop|
    attributes_table do
      row :city
      row :group
      row :facebook_album_id
      row :release_date
      row :published
      row :registrations_enabled
      row :should_send_notification      
      row :created_at
      row :updated_at        
    end

    panel 'Content' do
      attributes_table_for workshop do
        row :description do
          raw workshop.description
        end 
        row :with_whom  do
          raw workshop.with_whom
        end 
        row :bring_along do
          raw workshop.bring_along
        end 
        row :whereabouts do
          raw workshop.whereabouts
        end 
      end
    end
    panel 'Donation' do
      attributes_table_for workshop do
        row :requires_donation
        row :donation do
          raw workshop.donation
        end
      end
    end
  end

  controller do
    def new
      city = City.find_by_domain(request.subdomains.first.to_s)
      @workshop = Workshop.new(:city => city, :donation => city.default_donation, :requires_donation => true, :should_send_notification => true, whereabouts: city.default_whereabouts)
      super
    end 

    def scoped_collection
      end_of_association_chain.includes(:translations => [])
    end
  end


  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :name, :facebook_album_id, :city_id, :group_id, :published, :release_date, :should_send_notification,
      :description, :with_whom, :bring_along, :whereabouts, :requires_donation, :donation, :registrations_enabled
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end


end
