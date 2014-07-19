class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :email
      t.integer :mailing_list_id
      
      t.timestamps
    end

    add_index :subscribers, :email, name: "index_subscribers_on_email"
    add_index :subscribers, :mailing_list_id
    add_index :subscribers, [:mailing_list_id, :email], unique: true
  end
end
