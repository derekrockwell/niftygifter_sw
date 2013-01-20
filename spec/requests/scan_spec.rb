require 'spec_helper'

describe "new scan" do 

	it "logs in, scans UPC, adds to new recipient" do
		user = FactoryGirl.create(:user)
		user.confirm!
		visit new_user_session_path

		fill_in "Email", :with => user.email
		fill_in "Password", :with => "foobar"
		click_button "Sign In"

		#these scan amazon API queries will fail with a 503 sometimes...
		#amazon api can be a failboat.

		visit "/scans/find/852060003107"
		page.should have_content("Justin Bieber") #yup
		click_link "add"

		page.should have_content("Who's this for")
		fill_in "recipient_alias", :with => "Test Recipient"
		click_button "Add Someone New"

		page.should have_content ("Test Recipient's Wishlist")
	end
end