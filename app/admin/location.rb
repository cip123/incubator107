ActiveAdmin.register Location do
  belongs_to :city

  index do
    selectable_column
    id_column
    column :name
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
  filter :name
  filter :name
  filter :created_at


end
