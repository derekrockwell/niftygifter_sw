class RecipientsController < InheritedResources::Base
	before_filter :authenticate_user! 
	
	def new
		@recipient = current_user.recipients.build
	end

	def show
		@recipient = current_user.recipients.find(params[:id])
	end

	def create
		@recipient = current_user.recipients.create(params[:recipient])
		redirect_to recipient_path(@recipient)
	end

	def index
		@new_recipient = current_user.recipients.build
		@recipients = current_user.recipients

		respond_to do |format|
			format.html
			format.json { render :json => @recipients, :only => [:alias, :id] }
		end

	end

	def destroy
		@recipient = current_user.recipients.find(params[:id])
		@recipient.destroy
		redirect_to root_path
	end


end
