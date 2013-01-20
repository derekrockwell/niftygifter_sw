class EventsController < InheritedResources::Base
	before_filter :authenticate_user! 

	def new
		@event = current_user.events.build

		begin
			@selected_recipient_id = current_user.recipients.find(params[:recipient_id]).id
		rescue 
			@selected_recipient_id = nil
		end
	end

	def update
	end

	def create
		@event = Event.new(params[:event])

		@event.set_time
		@event.save!

		send_sms(current_user,@event)

		redirect_to events_path, :notice => "Event Added"
	end

	def index
		@events = current_user.events.limit(10)
	end

	def destroy
		@event = current_user.events.find(params[:id])
		@event.destroy
		redirect_to root_path
	end

	private 
	def send_sms(user, event)
	    #temporary code until this has a permanent home w/ a scheduler
	    account_sid = ENV["TWILIO_ID"]
	    auth_token = ENV["TWILIO_AUTH"]

	    unless Rails.env.test?
	    	begin
	    		@twilio = Twilio::REST::Client.new account_sid, auth_token
	    		@account = @twilio.account
	    		@message = @account.sms.messages.create({:from => '+16122354981', :to => user.phone, 
	    			:body => "" << event.recipient.alias << "'s " << event.name << " is coming up... Visit " << recipient_url(event.recipient)  << " and buy them something!"})
	    		puts @message	
	    	rescue
	    	end
	    end	
	end
end
