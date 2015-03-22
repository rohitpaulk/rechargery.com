class Order < ActiveRecord::Base
	belongs_to :user
	belongs_to :store
	belongs_to :tracking
	has_one :recharge,:dependent => :destroy

	after_update :sendemails

	scope :pending, -> {where(:status => 0)}
	scope :confirmed, -> {where(:status => 1)}
	scope :completed, -> {where(:status => 2)}
	scope :failed, -> {where(:status => 3)}

	validates_presence_of(:user,:message => "This order doesn't belong to a user!")
	validates_presence_of(:store,:message => "This order doesn't belong to a Store!")
	#validates_presence_of(:shopname,:message => "You haven't chosen a shop")
	#validates_inclusion_of(:shopname,:in => 1..3,:message => "Invalid Store Name")
	validates_numericality_of(:status, :message => "Status code invalid")
	validates_inclusion_of(:status,:in => 0..4,:message => "Invalid Status Code")
	validates_format_of(:emailused, :with => /@/, :allow_blank => true, :message => "Please enter a valid email address")

	validates_presence_of(:orderid,if: :is_amazon? ,:message => "You haven't provided us with an Order ID")
	validates_presence_of(:emailused, if: :is_amazon?, :message => "Please enter an email address for your Amazon Order")
	#validates_uniqueness_of(:orderid, :scope => [:shopname], :message => "An order has been created with this Order ID already")
	validates_numericality_of(:ordertotal, if: :is_amazon?, :message => "Invalid order total. Order total should be a number")

	validates_presence_of(:amount,if: :amountstatus,:message => "Amount is not present")
	validates_numericality_of(:amount, :message => "Amount should be an integer", :allow_blank => true)
	validate :amountisdivby10

	def amountisdivby10
		if !amount.nil? && amount%10!=0
			errors.add(:amount, "Amount has to be a multiple of 10.")
		end
	end

	def is_amazon?
		self.store && self.store.name == 'Amazon'
	end
	def sendemails
		if self.status==1
			UserMailer.order_tracked(self.user,self).deliver()
		elsif self.status==2
			UserMailer.recharge_successful(self.user,self).deliver()
			MixpanelTrackJob.new.async.perform(self.user.id,'Received Recharge',{
				'Amount'=> self.amount,
				'Phone Number'=> self.user.phone,
				'Provider' => self.user.providertext
			},nil)
		elsif self.status==3 || self.status==4
			UserMailer.order_failed(self.user,self).deliver()
		end
	end

	def self.statuskeys
		return {
			"Pending Review"=> 0,
			"Order Confirmed"=> 1,
			"Recharge Successful" => 2,
			"Confirmation Failed" => 3,
			"Recharge Failed" => 4
		}
	end

	def statustext
		return Order.statuskeys.key(status)
	end

	def shopnametext
		if self.store
			return self.store.name
		# elsif self.shopname == 1
		# 	return "Amazon"
		# elsif self.shopname == 2
		# 	return "Flipkart"
		# elsif self.shopname == 3
		# 	return "Myntra"
		end
	end

	def amounttext
		if self.amount == 0 || self.amount.blank?
			return "N/A"
		else
			return 'Rs.' + self.amount.to_s
		end
	end
	def actiontext
		if self.status == 0
			return "View Details"
		elsif self.status == 1
			return "View Details"
		elsif self.status == 2
			return "View Details"
		elsif self.status == 3
			return "View Details"
		elsif self.status == 4
			return "View Details"
		end
	end

	def amountstatus
		if self.status == 0 || self.status == 3
			return false
		else
			return true
		end
	end
	def datetext
		if self.tracking
			self.tracking.created_at.strftime("%e %b %Y")
		else
			self.created_at.strftime("%e %b %Y")
		end
	end
end