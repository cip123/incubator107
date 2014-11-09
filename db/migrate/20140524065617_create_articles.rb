class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|      
      t.boolean :published
      t.integer :city_id
      t.integer :alias  

      t.timestamps
    end

    add_index :articles,  :alias
    add_index :articles,  :city_id
    add_index :articles, [:city_id, :alias], unique: true


    Article.create_translation_table! :title => :string, :content => :text

  end

  def down
    drop_table :articles
    Article.drop_translation_table!
  end
end
