ActiveAdmin.register Event do
  
  belongs_to :workshop
  
  filter :start_date
  
  index do
    selectable_column
    id_column
    column :start_date, :sortable => :start_date do |event|
      event.start_date.strftime('%F %R')  
    end
    column :location, sortable: "location_translations.name"
    column :duration
    actions
  end

  show do |event|
      attributes_table do
        row :location
        row :start_date do
          event.start_date.strftime('%F %R')
        end
        row :duration
      end
  end



  form do |f|
    f.inputs "Event details" do
      f.input :location
      f.input :start_date, :as => :just_datetime_picker
      f.input :duration, :input_html => { :min => 15, :max => 800, :step => 15, :class => "number-spinner" }
     end

    f.actions
  end

  # controller do
  #   def scoped_collection
  #     Event.includes(:workshop)
  #   end
  # end

  #filter :workshop
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :location_id, :start_date, :duration, :start_date_date, :start_date_time_hour, :start_date_time_minute
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
 
  controller do
    def scoped_collection
      end_of_association_chain.includes(location: [translations: []])
    end
  end

end
