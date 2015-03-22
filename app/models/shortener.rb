class Shortener < ActiveRecord::Base
	include Rails.application.routes.url_helpers
	validates_presence_of(:in_url, :message => "Enter the input URL! (short)")
	validates_presence_of(:out_url, :message => "Enter the output URL! (long)")
	validates_uniqueness_of(:in_url, :message => "This shortcode already exists!")
	def finallink
		"http://rechargery.com/" + 'link/'+self.in_url
	end
end
