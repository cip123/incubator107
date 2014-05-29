class CreateMailingListSubscribers < ActiveRecord::Migration
  def change
    create_table :mailing_list_subscribers do |t|
      t.integer :subscriber_id
      t.integer :mailing_list_id

      t.timestamps
    end
  end
end
