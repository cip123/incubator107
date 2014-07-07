class CreateCityUsers < ActiveRecord::Migration
  def change
    create_join_table :cities, :users
  end
end
