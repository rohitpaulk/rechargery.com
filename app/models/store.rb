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

	validates_presence_of :name, message: "Store name not provided!"
	validates_presence_of :status, message: "Store status not provided!"
	validates_presence_of :image_name, message: "You haven't provided an image_name"
	validates_presence_of :tracker_urlidentifier, message: "You haven't provided a tracking url identifier"
	validates_inclusion_of :status, in: 0..2, message: "Status should be 0, 1 or 2"

	def self.find_by_slug(slug)
		Store.all.select { |store|
			store.slug == slug
		}.first
	end

	def self.statuskeys
		{
			"Off" => 0,
			"Beta" => 1,
			"Live" => 2
		}
	end

	def self.trackertypes
		{
			"Amazon" => 0,
			"OMGPM" => 1,
			"Flipkart" => 2
		}
	end

	def slug
		return name.parameterize
	end

	def beta?
		self.status == 1
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

	def get_redirect_url(url, tracking_id)
		case tracker_type
		when 0 # Amazon
			url = overrid_affiliate(url)
			if url[-1] == '?'
				urldest = url + tracker_afftag[1..-1]
			else
				urldest = url + tracker_afftag
			end
			urldest = urldest.gsub('?','&')
			urldest = urldest.sub('&','?')
			return urldest
		when 1 # OMGPM
			urldest = url + tracker_afftag
			urldest = urldest.gsub('?','&')
			urldest = urldest.sub('&','?')
			return tracker_baseurl + "&UID=" + tracking_id.to_s + tracker_deeplinker + CGI::escape(urldest)
		when 2 # FlipKart
			urldest = url + tracker_afftag
			urldest = urldest + "&affExtParam1="+ tracking_id.to_s
			urldest = urldest.gsub('?','&')
			urldest = urldest.sub('&','?')
			return urldest
		end
	end

	def overrid_affiliate(url)
		if url.include?"tag="
			pos = url.index("tag=")
			sub = url[pos..-1]
			if sub.include?"&"
				pos = sub.index('&')
				sub = sub[0..pos]
			elsif url[pos-1] == '&'
				sub = url[pos-1..-1]
			end
			url.slice!(sub)
		end
		return url
	end
end
