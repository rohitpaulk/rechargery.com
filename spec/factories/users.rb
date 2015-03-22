require 'faker'

FactoryGirl.define do
	factory :user do |f|
		f.name "Rohit Paul"
		f.phone "9501499829"
		f.phone_operator 1
		f.sequence(:email) {|n| "email#{n}@factory.com" }
		f.password "secret123"
	end
end
