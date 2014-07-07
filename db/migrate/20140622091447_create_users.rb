class CreateUsers < ActiveRecord::Migration

  def self.up

    create_table :users do |t|
      t.string "name"
      t.string "email"
      t.string "password_digest"
      t.string "remember_token"
      t.column :role, :integer, default: 0
      t.string :password_reset_token
      t.datetime :password_reset_sent_at

      t.timestamps
    end



    add_index "users", ["email"], name: "index_users_on_email", unique: true
    add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  end

  def self.down
    drop_table :users
  end


end
