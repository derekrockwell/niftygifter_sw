class Scan < ActiveRecord::Base
  default_scope order('created_at desc')
  belongs_to :user
  belongs_to :recipient

  validates_presence_of :upc

  accepts_nested_attributes_for :recipient

  attr_accessible :user_id, :recipient_id, :upc, :recipient_attributes


  def get_response
  	if(self.upc.length == 13)
  		Amazon::Ecs.item_lookup(self.upc, {:id_type => "EAN", :search_index => 'All', :response_group => 'Large, Images'})
  	else
      Amazon::Ecs.item_lookup(self.upc, {:id_type => "UPC", :search_index => 'All', :response_group => 'Large, Images'})
    end

  end

end
