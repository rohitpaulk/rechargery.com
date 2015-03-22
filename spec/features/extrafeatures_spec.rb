require 'spec_helper'

feature "Menu bar" do
	context "Not Logged In" do
		scenario "view homepage when not logged in" do
			visit "/"
			within(".home-navigation") do
				expect(page).to have_content("Login")
			end
		end

		scenario "view howitworks when not logged in" do
			visit "/"
			click_link "How it works"
			within(".home-navigation") do
				expect(page).to have_content("Login")
			end
		end
	end

	context "Logged in" do
		before do
			@user = FactoryGirl.create(:user, password: "abcd")
			sign_in_with(@user.email, "abcd")
		end

		scenario "view homepage when logged in" do
			visit "/"
			within(".home-navigation") do
				expect(page).to have_content("Dashboard")
			end
		end

		scenario "view homepage when logged in" do
			visit "/"
			click_link "How it works"
			within(".home-navigation") do
				expect(page).to have_content("Dashboard")
			end
		end
	end
end
