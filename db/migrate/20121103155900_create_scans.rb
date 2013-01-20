class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|

      t.timestamps
    end
  end
end
