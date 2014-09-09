namespace :mailchimp do
  desc "Create groups to use with mailchimps"
  task :create_groups => :environment do | t, args|

    City.all.each do |city|

      next if city.mailchimp_key.blank?

      gibbon = Gibbon::API.new(city.mailchimp_key)
      puts gibbon.lists.interest_groupings({ id: city.workshop_list_id})

      if (city.workshop_groups_id.blank?)
        puts "Creating mailchimp grouping for #{city.name}"
        response = gibbon.lists.interest_grouping_add({ id: city.workshop_list_id, name: "groups", type: "radio", groups: Group.all.map(&:name) })
        city.workshop_groups_id = response["id"]
        city.save
      end

      # groupings =  mailchimp.lists.interest_groupings(city.workshop_list_id)

      # grouping = nil

      # groupings.each do |g|
      #   if (g["id"] == city.workshop_groups_id.to_i)
      #     grouping = g
      #     break
      #   end
      # end

      # mailchimp_group_names = grouping["groups"].each.map{ |x| x["name"] }

      # Group.all.each do | group |
      #   if !mailchimp_group_names.include? group.name
      #     puts "Creating mailchimp group #{group.name}"
      #     mailchimp.lists.interest_group_add( city.workshop_list_id, group.name, city.workshop_groups_id)
      #   end      
      # end
    
    end

  end

end
