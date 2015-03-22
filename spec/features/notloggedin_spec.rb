require 'spec_helper'

feature "Redirect if not logged in" do
	before do
		@user = FactoryGirl.create(:user, password: "abcd")
	end

	scenario "try to access /profile" do
		visit "/profile"
		expect(page.current_path).to eq("/login")
		within("//form[@action='/login']") do
				fill_in "Email", :with => @user.email
				fill_in "Password", :with => "abcd"
		end
		click_button "Login"
		expect(page.current_path).to eq("/profile")
	end
end
