ActiveAdmin.register Event do
  
  belongs_to :workshop
  
  index do
    selectable_column
    id_column
    column :start_date, :sortable => :start_date do |event|
      event.start_date.strftime('%F %R')  
    end
    column :location
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

  filter :start_date
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :location_id, :start_date, :duration
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
