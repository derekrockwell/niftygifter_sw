class Event < ActiveRecord::Base
	default_scope order('event_time desc')
	belongs_to :recipient
	has_many :users, :through => :recipient

	attr_accessible :name, :recipient_id, :reminder, :event_time, :day, :month

	accepts_nested_attributes_for :recipient

	validates_presence_of :event_time
	validates_presence_of :name, :message => "Event requires a name"
	validates_presence_of :recipient_id, :message => "Events require a valid recipient"

	def set_time
		begin
			day = self.day
			month = self.month
			date = Date.new(Time.now.year,month,day)

			if(date.past?)
				date = date.next_year
			end

			self.event_time = date
		rescue
			raise
		end
		true
	end
end
