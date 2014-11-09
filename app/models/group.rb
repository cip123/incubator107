class Group < ActiveRecord::Base
  translates :name

  default_scope -> { includes :translations }

  has_attached_file :image
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  def add_to_mailchimp person
    
    return if person.city.mailchimp_key.blank?
    
    merge_vars = {
      groupings: [ 
        id: person.city.mailchimp_workshop_groups_id, 
        groups: [ name ] 
        ] 
    }
    
    gibbon = Gibbon::API.new(person.city.mailchimp_key)    
    gibbon.lists.subscribe({id: person.city.mailchimp_workshop_list_id, email: { email: person.email }, merge_vars: merge_vars, double_optin: false, replace_interests: false, update_existing: true  })


  end


end
