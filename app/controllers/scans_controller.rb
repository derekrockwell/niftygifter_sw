class ScansController < InheritedResources::Base
	before_filter :authenticate_user! 

	def show
		@scan = current_user.scans.find(params[:id])
	end

	def index
		@scans = current_user.scans.limit(10)
	end

	#/scans/:scan_id/recipients/new - get
	def new
		@scan = current_user.scans.build
		@scan.upc = params[:scan_id]
		@response = @scan.get_response
		@new_recipient = @current_user.recipients.build		
		@recipients = @current_user.recipients
	end

	#post from /scans/:scan_id/recipients/new
	def create
		@scan = current_user.scans.build(:upc => params[:scan_id])
		@recipient = current_user.recipients.create(params[:recipient])
		@scan.recipient = @recipient
		@scan.save!
		redirect_to recipient_path(@scan.recipient.id)
	end

	#put from /scans/123/recipients/new
	def update
		@scan = current_user.scans.build(:upc => params[:scan_id])
		@recipient = current_user.recipients.find(params[:id])
		@scan.recipient = @recipient
		@scan.save!
		redirect_to recipient_path(@scan.recipient.id)
	end

	def destroy  
		@scan = current_user.scans.find(params[:id])
		@scan.destroy  
		respond_to do |format|  
			format.html { redirect_to(scans_url) }  
			format.js   { render :nothing => true }  
		end 
	end
	
	#/scans/find/:upc
	def find
		@scan = current_user.scans.build
		@scan.upc = params[:upc]
		@res = @scan.get_response
	end

end
