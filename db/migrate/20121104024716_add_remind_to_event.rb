class AddRemindToEvent < ActiveRecord::Migration
  def change
  	  add_column :events, :reminder, :integer
  end
end
