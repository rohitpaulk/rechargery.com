class Tracking < ActiveRecord::Base
	belongs_to :store
	belongs_to :user
	has_one :order

	validates_presence_of :url

	after_create :create_finalurl

	# def self.details
	# 	trackers = [
	# 		["flipkart",2,"flipkart.com","","","&affid=rohitkuruv"],
	# 		["amazon",0,"amazon.in","","","&tag=rechargery-21"],
	# 		["myntra",1,"myntra.com","http://track.in.omgpm.com/?AID=556244&MID=349836&PID=9640&CID=4030497&WID=49514","&r=",""],
	# 		["yebhi",1,"yebhi.com","http://track.in.omgpm.com/?AID=556244&MID=248729&PID=8782&CID=4034676&WID=49514","&r=",""],
	# 		["jabong",1,"jabong.com","http://track.in.omgpm.com/?AID=556244&MID=304697&PID=9170&CID=4035676&WID=49514","&r=",""],
	# 		["zovi",1,"zovi.com","http://track.in.omgpm.com/?AID=556244&MID=218153&PID=8422&CID=4035995&WID=49514","&r=",""]
	# 	]
	# end

	def create_finalurl
		Store.all.each do |store_obj|
			if url.include?(store_obj.tracker_urlidentifier)
				self.store = store_obj
		 		self.finalurl = store.get_redirect_url(url, id)
		 		self.save!
			end
		end
	end
end
