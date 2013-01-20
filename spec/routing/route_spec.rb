require 'spec_helper'

describe "account routes" do
	it "routes /users/login to devise" do
		expect(:get => "/users/sign_in").to route_to(
			:controller => "devise/sessions",
			:action => "new"
		)
	end
end
