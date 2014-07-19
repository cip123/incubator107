ActiveAdmin.register MailingList do

  sidebar "Associations", only: [:show, :edit] do
    ul do
      li link_to "Subscribers", admin_mailing_list_subscribers_path(mailing_list.id)
    end
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
  
end
