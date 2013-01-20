require 'spec_helper'

describe "recipient" do 

	it "add new recipient" do
		user = FactoryGirl.create(:user_with_events)
		user.confirm!
		visit new_user_session_path

		fill_in "Email", :with => user.email
		fill_in "Password", :with => "foobar"
		click_button "Sign In"

		click_button "Gift Lists"
		page.should have_content("Your Recipients")

		click_link "Create New Recipient"

		fill_in "event_name", :with => "Birthday"
		click_button "Create Event"

		page.should have_content("Upcoming Events")
		page.should have_content("Event Added")

	end
end