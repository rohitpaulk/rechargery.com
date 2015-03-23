require_relative '../spec_helper'

describe "Recharge" do
  it "has a valid factory" do
    FactoryGirl.create(:recharge).should be_valid
  end

  it "is invalid without phone number" do
    FactoryGirl.build(:recharge,phonenumber: nil).should_not be_valid
  end
  it "is invalid without circle code" do
    FactoryGirl.build(:recharge,circlecode: nil).should_not be_valid
  end
  it "is invalid without operator code" do
    FactoryGirl.build(:recharge,operatorcode: nil).should_not be_valid
  end

  it "belongs to order" do
    FactoryGirl.build(:recharge,order:nil).should_not be_valid
  end
  it "is invalid with weird phone number" do
    FactoryGirl.build(:recharge,phonenumber: "abcd").should_not be_valid
    FactoryGirl.build(:recharge,phonenumber: "1234").should_not be_valid
  end

  it "is invalid with weird circlecode" do
    FactoryGirl.build(:recharge,circlecode: "a").should_not be_valid
    FactoryGirl.build(:recharge,circlecode: 123).should_not be_valid
  end
  it "is invalid with weird operator code" do
    FactoryGirl.build(:recharge,operatorcode: "b").should_not be_valid
    FactoryGirl.build(:recharge,operatorcode: 124).should_not be_valid
  end
end
