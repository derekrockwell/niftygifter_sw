class AddEventToScan < ActiveRecord::Migration
  def change
  	add_column :scans, :event_id, :integer
  end
end
