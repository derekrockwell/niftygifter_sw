class AddRecipientToScan < ActiveRecord::Migration
  def change
  	add_column :scans, :recipient_id, :integer
  end
end
