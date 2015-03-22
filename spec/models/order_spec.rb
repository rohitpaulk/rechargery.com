require_relative '../spec_helper'

describe Order do
	it "has a valid factory" do
		FactoryGirl.create(:order).should be_valid
	end
	it "is invalid without order status" do
		FactoryGirl.build(:order,status: nil).should_not be_valid
	end
	it "is invalid without store" do
		FactoryGirl.build(:order,store_id: nil).should_not be_valid
	end
	it "is invalid without email used if Amazon" do
		FactoryGirl.build(:order,emailused: nil).should be_valid
		FactoryGirl.build(:order,emailused: nil, :store => FactoryGirl.create(:amazon_store)).should_not be_valid
	end
	it "is invalid without order ID if Amazon" do
		FactoryGirl.build(:order,orderid: nil).should be_valid
		FactoryGirl.build(:order,orderid: nil, :store => FactoryGirl.create(:amazon_store)).should_not be_valid
	end
	it "is invalid without order total if Amazon" do
		FactoryGirl.build(:order,ordertotal: nil).should be_valid
		FactoryGirl.build(:order,ordertotal: nil, :store => FactoryGirl.create(:amazon_store)).should_not be_valid
	end
	it "is invalid with weird email used" do

		FactoryGirl.build(:order,emailused: "abcd").should_not be_valid
	end
	it "is invalid with weird status" do
		FactoryGirl.build(:order,status: "a").should_not be_valid
		FactoryGirl.build(:order,status: "123").should_not be_valid
	end
	it "is invalid with weird recharge amount" do
		FactoryGirl.build(:order,amount: "a").should_not be_valid
		FactoryGirl.build(:order,amount: 9).should_not be_valid
	end
	# it "is invalid with weird shopname" do
	# 	FactoryGirl.build(:order,shopname: 4).should_not be_valid
	# 	FactoryGirl.build(:order,shopname: "abcd").should_not be_valid
	# end
	it "should belong to a user" do
		FactoryGirl.build(:order,user: nil).should_not be_valid
	end
end

