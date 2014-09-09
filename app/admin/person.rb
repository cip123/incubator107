ActiveAdmin.register Person do
 
  form do |f|
    f.inputs "Person details" do
      f.input :name
      f.input :email
      f.input :phone
      f.input :verified
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :verified
    column :city

    actions
  end


  # controller do
  #   def new
      
  #     puts params.inspect
  #     @person = Person.new()
  #     @person.workshop_persons.build(:workshop_id => params[:workshop_id])
  #     super
  #   end 
  # end


  filter :name
  filter :email
  filter :verified
  filter :city
  filter :created_at


  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  #permit_params :name, :email, :phone, :verified
  permit_params :name, :email, :phone, :verified, :_destroy
  
end
