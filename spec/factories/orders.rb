require 'faker'

FactoryGirl.define do
	factory :order do |f|
		f.sequence(:orderid) {|n| "123456789#{n}"}
		f.emailused "rohitkuruvilla@yahoo.co.in"
		f.status 0
		user
		store
	end
	factory :myntra_order, parent: :order do |f|

	end

end