class HomeController < ApplicationController 

  def index
  	if user_signed_in?
  		@graph = Koala::Facebook::API.new(current_user.access_token)
  		render 'user_main'
  	else
  		render 'index'
  	end
  end

  def login
  end

end
