class CreateGroups < ActiveRecord::Migration
  def up
    create_table :groups do |t|
      t.integer :index
      t.boolean :active
      t.attachment :image

      t.timestamps
    end
    Group.create_translation_table! :name => :string
  end

  def down
    drop_table :groups
    Group.drop_translation_table!
  end
end
