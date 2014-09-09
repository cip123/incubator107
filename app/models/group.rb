class Group < ActiveRecord::Base
  translates :name
  has_many :group_mailing_lists
  has_many :mailing_lists, through: :group_mailing_lists

  default_scope -> { includes :translations }

  def add_to_mailchimp person
    
    return if person.city.mailchimp_key.blank?
    
    merge_vars = {
      groupings: [ 
        id: person.city.workshop_groups_id, 
        groups: [ name ] 
        ] 
    }
    
    gibbon = Gibbon::API.new(person.city.mailchimp_key)    
    gibbon.lists.subscribe({id: person.city.workshop_list_id, email: { email: person.email }, merge_vars: merge_vars, double_optin: false, replace_interests: false, update_existing: true  })


  end


end
