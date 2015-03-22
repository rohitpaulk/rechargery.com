# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :store do |f|
		f.name "Flipkart"
		f.status 2
		f.tracker_urlidentifier "Flipkart.com"
	end
	factory :amazon_store, parent: :store do |f|
		f.name "Amazon"
		f.status 2
		f.tracker_urlidentifier "amazon.in"
	end

end
