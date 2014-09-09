# ActiveAdmin.register MailchimpList do
#    menu parent: "Settings"


#     # page_action :ex, :method => :post do
#     #   # do stuff here
#     #   redirect_to admin_my_page_path, :notice => "You did stuff!"
#     # end

#     action_item only: [ :index ] do
#       link_to "Retrieve Mailchimp Lists", synchronize_admin_mailchimp_lists_path, :method => :post
#     end

#   collection_action :synchronize, :method => :post do

#       City.all.each do |city|

#         if city.mailchimp_key 
#           mailchimp = Mailchimp::API.new(city.mailchimp_key)
#           lists =  mailchimp.lists.list["data"]

#           lists.each do |list|
#             puts list.inspect
         
#             if ( list["name"] ==  city.mailing_list.name ) || ( Group.all.map(&:name).include? list["name"] )
#               mailchimp_list = MailchimpList.find_or_initialize_by( city_id: city.id , name: list["name"]) 
#               mailchimp_list.mailchimp_id =list["id"]
#               mailchimp_list.save
#             end
#           end
#         end
#       end
    



   
#       #puts current_list



#       # Do some CSV importing work here...
#     flash[:notice] = "CSV imported successfully!"
#     redirect_to  action: 'index'
#   end
  

#   index do
#     selectable_column
#     id_column
#     column :name
#     column :city
#     column :mailchimp_id, label: "Code"

#     column :updated_at

#     actions
#   end

#   # permit_params :email, :password, :password_confirmation

#   # index do
#   #   selectable_column
#   #   id_column
#   #   column :email
#   #   column :current_sign_in_at
#   #   column :sign_in_count
#   #   column :created_at
#   #   actions
#   # end

#   # filter :email
#   # filter :current_sign_in_at
#   # filter :sign_in_count
#   # filter :created_at

#   form do |f|
#     f.inputs  do
#       f.input :name
#       f.input :city, :include_blank => false
#       f.input :mailchimp_id, :label => "Mailchimp List Id"
#     end
#     f.actions
#   end

#   permit_params :name, :city_id, :mailchimp_id

# end
