class CreateContactPeople < ActiveRecord::Migration
  def up
    create_table :contact_people do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.integer :city_id
      t.integer :index
      t.timestamps
    end
    ContactPerson.create_translation_table! :title => :string, :about => :text, :team => :string
  end
  
  def down
    drop_table :contact_people
    ContactPeople.drop_translation_table!
  end 
end
