class TrackingController < ApplicationController
	def redirect
		url = params[:url]
		userid = params[:user]
		tracker = Tracking.create(url: url, user_id: userid)
		if tracker.finalurl
			redirect_to(tracker.finalurl)
			MixpanelTrackJob.new.async.perform(userid,'Tracked URL',{
				'Store' => tracker.store.name,
				'URL' => url
			},request.remote_ip)
		else
			flash[:alert] = "Not a valid URL, please try again"
			redirect_to(dashboard_path)
		end
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
