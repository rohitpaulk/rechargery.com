class ShortenersController < ApplicationController
	
	def redirectlink
		@result = Shortener.where(:in_url => params[:in_url])
		redirect_to(@result[0].out_url,status:301)
	end
	
end
