class CreateWorkshopRequests < ActiveRecord::Migration
  def change
    create_table  :workshop_requests do |t|
      t.integer   :workshop_id
      t.integer   :person_id
      t.text    :reason

      t.timestamps
    end
  end
end
