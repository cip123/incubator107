class AddRegistrationsEnabledToWorkshops < ActiveRecord::Migration
  def change
      add_column :workshops, :registrations_enabled, :boolean, :default => true
  end
end
