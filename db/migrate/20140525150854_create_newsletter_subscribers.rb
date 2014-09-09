class CreateNewsletterSubscribers < ActiveRecord::Migration
  def change
    create_table :newsletter_subscribers do |t|
      t.string :email
      t.references :city
      
      t.timestamps
    end

    add_index :newsletter_subscribers, :email, name: "index_subscribers_on_email"
    add_index :newsletter_subscribers, :city_id
    add_index :newsletter_subscribers, [:city_id, :email], unique: true
  end
end
