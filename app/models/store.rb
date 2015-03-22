# t.string   "name"
# t.string   "image_name"
# t.text     "short_desc"
# t.text     "long_desc"
# t.integer  "status"
# t.integer  "tracking_reliability"
# t.boolean  "adblock_compatibility"
# t.integer  "payment_method"
# t.datetime "created_at"
# t.datetime "updated_at"
# t.integer  "tracker_type"
# t.string   "tracker_urlidentifier"
# t.string   "tracker_storeurl"
# t.string   "tracker_baseurl"
# t.string   "tracker_deeplinker"
# t.string   "tracker_afftag"

class Store < ActiveRecord::Base
	has_many :trackings
	has_many :orders
	has_and_belongs_to_many :categories, join_table: :categories_stores

	validates_presence_of(:name,:message => "Store name not provided!")
	validates_presence_of(:status,:message => "Store status not provided!")
	validates_inclusion_of(:status, :in => 0..2)

	validates_presence_of(:tracker_urlidentifier, :message => "You haven't provided a tracking url identifier")

	def self.find_by_slug(slug)
		Store.all.each do |store|
			return store if store.slug == slug
		end
		return false
	end
	def slug
		return name.parameterize
	end
	def self.statuskeys
		return {
			"Off" => 0,
			"Beta" => 1,
			"Live" => 2
		}
	end
	def beta?
		self.status == 1
	end
	def self.trackertypes
		return {
			"Amazon" => 0,
			"OMGPM" => 1,
			"Flipkart" => 2
		}
	end
	def timeperiod
		if tracker_type == Store.trackertypes["Amazon"]
			return "30-45 days"
		elsif tracker_type == Store.trackertypes["Flipkart"]
			return "30-45 days"
		elsif tracker_type == Store.trackertypes["OMGPM"]
			return "45-60 days"
		end
	end
	
	def redirecturl(tracker_id)
		Tracking.getredirecturl(self.tracker_storeurl,tracker_id)
	end	
end
