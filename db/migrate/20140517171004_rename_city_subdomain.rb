class RenameCitySubdomain < ActiveRecord::Migration
  def change
    rename_column :cities, :subdomain, :domain
  end
end
