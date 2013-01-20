class AddUpcToScans < ActiveRecord::Migration
  def change
  	add_column :scans, :upc, :string
  end
end
