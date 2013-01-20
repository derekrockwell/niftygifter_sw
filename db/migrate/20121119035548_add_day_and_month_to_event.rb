class AddDayAndMonthToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :day, :integer
  	add_column :events, :month, :integer
  end
end
