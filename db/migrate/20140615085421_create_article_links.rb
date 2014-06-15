class CreateArticleLinks < ActiveRecord::Migration
  def change
    create_table :article_links do |t|
      t.string :alias
      t.integer :city_id
      t.integer :article_id

      t.timestamps
    end

    add_index :article_links,  :alias
    add_index :article_links,  :city_id
    add_index :article_links, [:city_id, :alias], unique: true

  end
end
