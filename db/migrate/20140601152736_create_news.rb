class CreateNews < ActiveRecord::Migration

  def up
    create_table :news do |t|
      t.boolean :display
      t.timestamp :release_date
      t.timestamps
    end
    News.create_translation_table! :title => :string, :text => :text
  end

  def down
    drop_table :news
    News.drop_translation_table!
  end

end
