class TrackingController < ApplicationController
	def redirect
		url = params[:url]
		userid = params[:user]
		tracker = Tracking.new
		tracker.save
		finalurl = Tracking.getredirecturl(url,tracker.id)
		if finalurl
			redirect_to(finalurl[:redirecturl])
			MixpanelTrackJob.new.async.perform(userid,'Tracked URL',{
				'Store'=> finalurl[:store].name,
				'URL'=> url
			},request.remote_ip)
			tracker.store = finalurl[:store]
			tracker.finalurl = finalurl[:redirecturl]					
		else
			flash[:alert]="Not a valid URL, please create your order again"
			redirect_to(dashboard_path)			
		end
		tracker.url = url
		tracker.user_id = userid
		tracker.save		
	end

	def getorderstatus

	end
	def setadblock
		session[:adblock] = true
		render :text => "Set Adblock"
	end
	def unsetadblock
		session[:adblock] = false
		render :text => "Removed Adblock"
	end
end
