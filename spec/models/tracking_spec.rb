require 'spec_helper'

describe Tracking do
  it "has a valid factory" do
    FactoryGirl.create(:tracking).should be_valid
  end

  describe "validations" do
    it "isn't valid without a url" do
      expect(FactoryGirl.build(:tracking, url: nil)).to_not be_valid
    end
  end

  describe "callbacks" do
    before do
      Rails.application.load_seed
    end

    it "creates finalurl automatically" do
      tracking = FactoryGirl.create(:tracking, url: "http://www.flipkart.com/")
      expect(tracking.finalurl).to_not be_nil
    end
  end
end
