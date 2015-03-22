require 'spec_helper'

describe Tracking do
	it "has a valid factory" do
		FactoryGirl.create(:tracking).should be_valid
	end
	
end