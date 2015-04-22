require 'spec_helper'

feature "Sign up" do
	scenario "user submits proper attributes" do
		sign_up_with("Paul", "rohitkuruvilla@yahoo.co.in", "secret", "secret", "9501499829", 1)
		expect(page.current_path).to eq("/dashboard")
	end

	scenario "user submits wrong passwords" do
		sign_up_with("Paul", "rohitkuruvilla@yahoo.co.in", "secret", "secre", "9501499829", 1)
		expect(page).to have_content("Passwords don't match")
	end

	scenario "Registered User already exists" do
		@user = FactoryGirl.create(:user)
		sign_up_with("Paul", @user.email, "secret", "secret", "9501499829", 1)
		expect(page).to have_content("already have an account")
	end
end

feature "Log in", :type => :feature do
	before do
		@user = FactoryGirl.create(:user, password: "abcd123")
	end

	scenario "User signs in" do
		sign_in_with(@user.email, "abcd123")
		expect(page.current_path).to eq("/dashboard")
	end
end

feature "Edit profile" do
	before do
		@user = FactoryGirl.create(:user, password: "abcd")
		sign_in_with(@user.email, "abcd")
	end

	scenario "user submits proper attributes" do
		expect(page.current_path).to eq("/dashboard")
		visit('/account')
		fill_in "name", :with => "Rohit Paul"
		fill_in "phone", :with => "9501499821"
		click_button "Update Details"
		expect(page.current_path).to eq("/dashboard")
		expect(page).to have_content("Details Updated")
		visit('/account')
		expect(find_field('phone').value).to eq('9501499821')
	end

	scenario "user submits proper attributes" do
		expect(page.current_path).to eq("/dashboard")
		visit('/account')
		fill_in "name", :with => ""
		click_button "Update Details"
		expect(page.current_path).to eq('/account')
		expect(page).to have_content("You haven't entered a name")
	end

	include_examples 'login wall redirect', '/account'
end

feature "Change Password" do
 	before do
		@user = FactoryGirl.create(:user, password: 'abcd')
		sign_in_with(@user.email, 'abcd')
	end

	scenario "user submits proper attributes" do
		expect(page.current_path).to eq("/dashboard")
		click_link "Account"
		click_link "Change Password"
		fill_in 'password', :with => 'abcd'
		fill_in 'new_password', :with => 'new_password'
		fill_in 'new_password_confirmation', :with => 'new_password'
		click_button "Change Password"
		expect(page.current_path).to eq("/dashboard")
		expect(page).to have_content("Details Updated")
		logout
		sign_in_with(@user.email, 'new_password')
		expect(page.current_path).to eq("/dashboard")
	end

	scenario "user submits improper attributes" do
		expect(page.current_path).to eq("/dashboard")
		click_link "Account"
		click_link "Change Password"
		fill_in 'password', :with => 'abcd'
		fill_in 'new_password', :with => 'new_password'
		fill_in 'new_password_confirmation', :with => 'new_password2'
		click_button "Change Password"
		expect(page.current_path).to eq('/account/password')
		expect(page).to have_content("Passwords don't match")
		logout
		sign_in_with(@user.email, 'new_password')
		expect(page.current_path).to eq("/login")
	end

	include_examples 'login wall redirect', '/account/password'
 end

