require_relative '../spec_helper'

describe User do
	it "has a valid factory" do
		FactoryGirl.create(:user).should be_valid
	end

	describe "validations" do
		it "is invalid without a name" do
			FactoryGirl.build(:user, name: nil).should_not be_valid
		end

		it "is invalid without a password" do
			FactoryGirl.build(:user, password: nil).should_not be_valid
		end

		it "is invalid with weird phone numbers" do
			FactoryGirl.build(:user, phone: "919501499829").should_not be_valid
			FactoryGirl.build(:user, phone: "abcd").should_not be_valid
		end

		it "is invalid with weird phone operators" do
			pending
		end

		it "is invalid with a weird email address" do
			FactoryGirl.build(:user, email: "rohit").should_not be_valid
		end

		it "has a unique email" do
			FactoryGirl.create(:user, email: "rohitkuruvilla@yahoo.co.in")
			FactoryGirl.build(:user, email: "rohitkuruvilla@yahoo.co.in").should_not be_valid
		end
	end

	describe "#check_password" do
		before do
			@user = FactoryGirl.create(:user, password: "secret123")
		end

		it "returns true if password is correct" do
			expect(@user.check_password("secret123")).to eq(true)
		end

		it "returns false if password is incorrect" do
			expect(@user.check_password("WrongPassword")).to eq(false)
		end
	end
end

