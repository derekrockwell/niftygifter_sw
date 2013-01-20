class ApplicationController < ActionController::Base 
	protect_from_forgery

	def after_sending_reset_password_instructions_path_for(resource_name)
		new_user_session_path
	end

	def after_sign_out_path_for(resource_or_scope)
	  	new_user_session_path
	end	

	def after_update_path_for(resource_or_scope)
	  	edit_user_registration_path
	end		
	
end
