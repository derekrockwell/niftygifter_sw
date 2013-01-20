require 'spec_helper'

describe "registration" do

	describe "register user" do
		it "creates user and sends confirmation" do
			ActionMailer::Base.deliveries = []
			visit app_root_path
			click_link "Sign Up"
			fill_in "Email", :with => "test123@test123.com"
			fill_in "Password", :with => "test1234"
			fill_in "user_password_confirmation", :with => "test1234"
			click_button "Register Your Account Now"

			user = User.find_by_email("test123@test123.com")

			page.should have_content("has been sent to your email address")
			ActionMailer::Base.deliveries.last.to.should include("test123@test123.com")

			visit "/users/confirmation?confirmation_token=#{user.confirmation_token}"
			page.should have_content("Log Out")

		end
	end

	describe "invalid email registration" do
		it "fills in bad email" do
			ActionMailer::Base.deliveries = []
			visit app_root_path
			click_link "Sign Up"
			fill_in "Email", :with => "INVALID"
			fill_in "Password", :with => "test1234"
			fill_in "user_password_confirmation", :with => "test1234"
			click_button "Register Your Account Now"

			page.should have_content("Sign Up for an Account")
			ActionMailer::Base.deliveries.should eql []
		end
	end


end
