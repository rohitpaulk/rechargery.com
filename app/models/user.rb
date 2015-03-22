class User < ActiveRecord::Base
	has_many :orders,:dependent => :destroy
	has_many :trackings
	has_many :referrals, class_name: "User", foreign_key: "affiliate_id"
	belongs_to :affiliate, class_name: "User"


	validates_presence_of(:name, message: "You haven't entered a name")
	validates_presence_of(:email, message: "You haven't entered an email address")
	validates_format_of(:email, with: /@/, message: "Please enter a valid email address")
	#validates_presence_of(:phone, :allow_blank => true, :message => "You haven't entered a phone number")
	validates_length_of(:phone, is: 10, allow_blank: true, message: "Phone number should be only 10 digits long")

	validates_presence_of(:password_digest, message: "You haven't entered a password")
	validates_numericality_of(:phone, allow_blank: true, message: "Phone number should only contain digits 0-9")
	#validates_presence_of(:phone_operator, :message => "You haven't specified a mobile operator")
	#validates_numericality_of(:phone_operator, :message => "Invalid mobile operator")
	validates_inclusion_of(:phone_operator, in: 0..14, allow_blank: true, message: "Invalid Operator Code")

	#validates_confirmation_of(:password, :message => "Both passwords don't match")
	validates_uniqueness_of(:email, :allow_blank => true, message: "Sorry, this email has already been taken.")

	def reload
		@password = nil # Reset password
		super
	end

	def password
		@password ||= BCrypt::Password.new(password_digest) if password_digest
	end

	def password=(new_password)
		return unless new_password # Don't create a hash for an empty password
		@password = BCrypt::Password.create(new_password)
		self.password_digest = @password.to_s
	end

	def check_password(given_password)
		password == given_password
	end

	def orderscount
		self.orders.count
	end

	def providertext
		providers = Recharge.providers
		if self.phone_operator
			return providers[self.phone_operator][0]
		else
			return "Not Provided"
		end
	end

	def stats_pendingvalue
		total=0
		for order in self.orders.where(:status => 1)
			total=total+order.amount
		end
		return total
	end

	def stats_earnedvalue
		total=0
		for order in self.orders.where(:status => 2)
			total=total+order.amount
		end
		return total
	end

	def pendingorderscount
		self.orders.where(:status => 1).count
	end

	def successfulorderscount
		self.orders.where(:status => 2).count
	end

	def failedorderscount
		self.orders.where(:status => 3).count + self.orders.where(:status => 4).count
	end

	def rechargessuccessful
		a = 0
		for order in self.orders
			if (!(order.recharge.blank?)) && order.recharge.status==2
				a = a + 1
			end
		end
		return a
	end
end
