class CreateNews < ActiveRecord::Migration

  def up
    create_table :news do |t|
      t.boolean :published
      t.integer :city_id
      t.timestamp :release_date
      
      t.timestamps
    end
    News.create_translation_table! :title => :string, :content => :text
  end

  def down
    drop_table :news
    News.drop_translation_table!
  end

end
