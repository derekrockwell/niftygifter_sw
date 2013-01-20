class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.integer :recipient_id
    	t.string :name
    	t.datetime :time	
      t.timestamps
    end
  end
end
