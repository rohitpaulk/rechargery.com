require 'spec_helper'

feature "Create Amazon order" do
	before do
		@user = FactoryGirl.create(:user, password: "abcd")
		sign_in_with(@user.email, "abcd")
		FactoryGirl.create(:store)
		FactoryGirl.create(:amazon_store)
	end

	scenario "user submits proper attributes" do
		visit "/orders/newamazon"
		fill_in "orderid", :with => "OD123123123"
		fill_in "emailused", :with => "rohitpaul@iitrpr.ac.in"
		fill_in "productname", :with => "Sample"
		fill_in "ordertotal", :with => 1234
		click_button "Submit Order"
		expect(page.current_path).to eq("/dashboard")
		expect(page).to have_content("Your order will be confirmed")
	end

	scenario "user submits improper attributes" do
		visit "/orders/newamazon"
		fill_in "orderid", :with => "OD123123123"
		fill_in "emailused", :with => "rohitpauliitrpr.ac.in"
		fill_in "productname", :with => "Sample"
		click_button "Submit Order"
		expect(page.current_path).to eq("/orders/newamazon")
		expect(page).to have_content("Not able to create order")
	end
end


