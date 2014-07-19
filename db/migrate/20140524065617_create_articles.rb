class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|      
      t.boolean :published
      t.integer :city_id

      t.timestamps
    end

    Article.create_translation_table! :title => :string, :content => :text


  end

  def down
    drop_table :articles
    Article.drop_translation_table!
  end
end
