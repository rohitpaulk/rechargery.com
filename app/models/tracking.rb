class Tracking < ActiveRecord::Base
	belongs_to :store
	belongs_to :user
	has_one :order

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

	def self.getredirecturl(url,trackingid)
		finalurl = nil
		store_obj = nil
		Store.all.each do |store|
			if url.include?(store.tracker_urlidentifier)
				if store.tracker_type == 0 # Amazon
					landingpage = url
		 			urldest = landingpage + store.tracker_afftag
		 			urldest = urldest.gsub('?','&')
		 			urldest = urldest.sub('&','?')
		 			finalurl = urldest
		 			store_obj = store
		 			break
		 		elsif store.tracker_type == 1 # OMGPM
		 			landingpage = url
		 			urldest = landingpage + store.tracker_afftag
		 			urldest = urldest.gsub('?','&')
		 			urldest = urldest.sub('&','?')
		 			finalurl = store.tracker_baseurl + "&UID=" + trackingid.to_s + store.tracker_deeplinker + CGI::escape(urldest)
		 			store_obj = store
		 			break
		 		elsif store.tracker_type == 2 # FlipKart
		 			landingpage = url
		 			urldest = landingpage + store.tracker_afftag
		 			urldest = urldest + "&affExtParam1="+ trackingid.to_s
		 			urldest = urldest.gsub('?','&')
		 			urldest = urldest.sub('&','?')
		 			finalurl = urldest
		 			store_obj = store
		 			break
		 		end
			end
		end
		if finalurl
			return {:redirecturl => finalurl,:store => store_obj}
		else
			return false
		end
	end
end
