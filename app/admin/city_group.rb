ActiveAdmin.register CityGroup do
  menu parent: "Settings"
  

  # form do |f|
  #   f.inputs  do
  #     f.input :name
  #   end
  #   f.actions
  # end


  index do
    selectable_column
    id_column
    column :group
    column :city
    column :mailchimp_id

    actions
  end


  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
  permit_params :city_id, :group_id, :mailchimp_id
end
