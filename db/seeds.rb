# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

all_stores = Category.create(
	name: "All Stores"
)

Store.delete_all

Store.create(
	name: 'Amazon',
	status: 1,
	image_name: "amazon.png",
	tracking_reliability: 96,
	adblock_compatibility: true,
	payment_method: nil,
	categories: [all_stores],
	tracker_type: 0,
	tracker_urlidentifier: "amazon.in",
	tracker_storeurl: "http://www.amazon.in/",
	tracker_afftag: "rechargery-21"
)

Store.create(
	name: 'Flipkart',
	status: 2,
	image_name: "flipkart.png",
	tracking_reliability: 100,
	adblock_compatibility: true,
	payment_method: nil,
	categories: [all_stores],
	tracker_urlidentifier: "flipkart.com",
	tracker_type: 2,
	tracker_storeurl: "http://www.flipkart.com",
	tracker_afftag: "&affid=rohitkuruv"
)

Store.create(
	:name => "Myntra",
	:status => 2,
	:image_name => "myntra.png",
	:tracker_type => 1,
	:tracker_urlidentifier => "myntra.com",
	:tracker_storeurl => "http://www.myntra.com",
	:tracker_baseurl => "http://track.in.omgpm.com/?AID=556244&MID=349836&PID=9640&CID=4030497&WID=49514",
	:tracker_deeplinker => "&r=",
	:tracker_afftag => "",
	:categories => [all_stores]
)
