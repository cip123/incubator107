ActiveAdmin.register Person do

  filter :name
  filter :email
  filter :verified
  filter :city
  filter :created_at
 
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :verified
    column :city

    actions
  end

  permit_params :name, :email, :phone, :verified, :_destroy, :city_id

  form do |f|
    f.inputs "Person details" do
      f.input :name
      f.input :email
      f.input :phone
      f.input :city
      f.input :verified
    end

    f.actions
  end
 
  
end
