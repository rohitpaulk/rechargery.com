class Recharge < ActiveRecord::Base
	belongs_to :order

	validates_presence_of(:order,:message => "This recharge doesn't belong to a order!")
	validates_presence_of(:phonenumber, :message => "You haven't entered a mobile number")
	validates_length_of(:phonenumber, :is => 10,:message => "Phone number should be only 10 digits long")
	validates_numericality_of(:phonenumber,:message => "Phone number should only contain digits 0-9")

	validates_presence_of(:circlecode, :message => "You haven't chosen a circle/region")
	validates_numericality_of(:circlecode,:message=> "Invalid Circle Code")
	validates_inclusion_of(:circlecode,:in =>0..22,:message =>"Invalid Circle Code")

	validates_presence_of(:operatorcode, :message => "You haven't chosen a service provider")
	validates_numericality_of(:operatorcode,:message=> "Invalid Operator Code")
	validates_inclusion_of(:operatorcode,:in =>0..14,:message =>"Invalid Operator Code")

	def self.providers
		return [["Airtel",0], ["Vodafone",1], ["BSNL",2], ["Reliance CDMA",3], ["Reliance GSM",4], ["Aircel",5], ["MTNL",6], ["Idea",7], ["Tata Indicom",8], ["Loop Mobile",9], ["Tata Docomo",10], ["Virgin CDMA",11], ["MTS",12], ["Virgin GSM",13], ["S Tel",14]]
	end
	def self.circles
		return [["Andhra Pradesh",1], ["Assam",2], ["Bihar & Jharkhand",3], ["Chennai",4], ["Delhi & NCR",5], ["Gujarat",6], ["Haryana",7], ["Himachal Pradesh",8], ["Jammu & Kashmir",9], ["Karnataka",10], ["Kerala",11], ["Kolkata",12], ["Maharashtra & Goa (except Mumbai)",13], ["MP & Chattisgarh",14], ["Mumbai",15], ["North East",16], ["Orissa",17], ["Punjab",18], ["Rajasthan",19], ["Tamilnadu",20], ["UP(EAST)",21], ["UP(WEST) & Uttarakhand",22], ["West Bengal",23]]
	end
	def providertext
		providers = Recharge.providers
		return providers[self.operatorcode][0]
	end

	def circletext
		circles = Recharge.circles
		return circles[self.circlecode - 1][0]
	end

end
