require 'spec_helper'

feature "Authentication", :type => :feature do
	before do
		@user = FactoryGirl.create(:user, password: "abcd123")
	end

	scenario "User signs in" do
		sign_in_with(@user.email, "abcd123")
		expect(page.current_path).to eq("/dashboard")
	end
end
