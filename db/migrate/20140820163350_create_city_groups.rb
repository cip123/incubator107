class CreateCityGroups < ActiveRecord::Migration
  
  def up
    create_table :city_groups  do |t|
        t.references :group
        t.references :city
        t.integer :mailchimp_id

        t.timestamps
    end
  end

  def down
    drop_table :group_mailing_lists
  end

end
