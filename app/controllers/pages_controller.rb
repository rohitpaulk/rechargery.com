class PagesController < ApplicationController
	
	before_filter :trackaffiliate
	def trackaffiliate
		if params[:refer]
			session[:affiliate] = params[:refer]
		end
	end

	def oldhome
		@current_user = current_user
		render layout: "homepage"
		#MixpanelTrackJob.new.async.perform('anonymous','Viewed Homepage',{})		
	end

	def home
		@current_user = current_user
		render layout: "application_new"
	end
	def newhowitworks
		render layout:"application_new"
	end
	def newtestimonials
		render layout:"application_new"
	end
	def blitz
		render :text => '42'
	end

	def docs_tos
		render layout: "docs_new"
	end

	def docs_privacy
		render layout: "docs_new"
	end
end
