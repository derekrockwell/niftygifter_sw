require 'spec_helper'

describe "password reset" do 

	it "sends reset email for valid user on request" do

		user = FactoryGirl.create(:user)
		user.confirm!

		ActionMailer::Base.deliveries = []
		visit "/users/sign_in"
		click_link "Click Here"
		fill_in "Email", :with => user.email


		click_button "Send Password Reset Email"

		page.should have_content("You will receive an email")
		ActionMailer::Base.deliveries.last.to.should include(user.email)


	end

	it "resets the password" do
		
		user = FactoryGirl.create(:user, :reset_password_token => "something",:reset_password_sent_at => 1.hour.ago)
		user.confirm!

		visit "/users/password/edit?reset_password_token=something"
		page.should have_content("Change your password")

	end

	it "denies password reset" do
		
		user = FactoryGirl.create(:user, :reset_password_token => "something",:reset_password_sent_at => 1.hour.ago)
		user.confirm!

		visit "/users/password/edit?reset_password_token=notsomething"
		page.should have_content("Change your password")

		fill_in "Password", :with => "test1234"
		fill_in "Password confirmation", :with => "test1234"
		click_button "Change Password"
		page.should have_content("Reset password token is invalid")

	end


end