FactoryGirl.define do
	factory :recharge do |f|
		f.phonenumber "9501499829"
		f.circlecode 0
		f.operatorcode 0
		order
	end
end