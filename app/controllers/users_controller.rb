class UsersController < ApplicationController
	def login #Login / Sign Up page
		if(current_user)
			redirect_to(dashboard_path)
		end
		@return_to = params[:return_to]
	end

	def new_signup
		if(current_user)
			redirect_to(dashboard_path) and return
		end
		@user = User.new
		render layout:"application_new"
	end

	def new_login
		if(current_user)
			redirect_to(dashboard_path) and return
		end
		@return_to = params[:return_to]
		render layout:"application_new"
	end

	def createuser
		@user = User.new # For use in the view
		if User.find_by_email(params[:email])
			flash[:alert] = "You already have an account, try logging in!"
			render "new_signup", :layout => "application_new" and return
		end
		@user.name = params[:name]
		@user.email = params[:email]
		@user.phone = params[:phone]
		if params[:password]==params[:password_confirmation]
			@user.password = params[:password]
		else
			flash[:alert]="Passwords don't match"
			render "new_signup", :layout => "application_new" and return
		end
		@user.phone_operator = params[:phone_operator]
		if session[:affiliate] && User.exists?(session[:affiliate])
			@user.affiliate_id = session[:affiliate]
		end
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "User Created"
			redirect_to(dashboard_path)
			UserMailer.registration_confirmation(@user).deliver
			ip = request.remote_ip
			MixpanelTrackJob.new.async.perform(@user.id, 'Created Account', {}, ip)
			MixpanelPeopleJob.new.async.perform(@user.id, {
				"$name"=> @user.name,
				"$email"=> @user.email,
				"$phone"=> @user.phone
			}, request.remote_ip)
		else
			flash[:alert] = "Oops! Couldn't create an account!"
			render "new_signup",:layout => "application_new"
		end
	end

	def facebookcallback
		omniauth = request.env["omniauth.auth"]
		if User.find_by_uid(omniauth['uid']) # If the FB auth exists
			session[:user_id] = User.find_by_uid(omniauth['uid']).id
			flash[:notice] = "Welcome back!"
			redirect_to(dashboard_path)
		elsif !(User.find_by_email(omniauth['info']['email'])) # If user doesn't exist
			@user=User.new
			@user.name = omniauth['info']['name']
			@user.email = omniauth['info']['email']
			@user.fbaccesstoken = omniauth['credentials']['token']
			@user.provider = omniauth['provider']
			@user.uid = omniauth['uid']
			randompass = ('a'..'z').to_a.shuffle[0,5].join
			@user.password = randompass
			if session[:affiliate] && User.exists?(session[:affiliate])
				@user.affiliate_id = session[:affiliate]
			end
			if @user.save
				session[:user_id] = @user.id
				flash[:notice] = "User Created"
				redirect_to(dashboard_path)
				UserMailer.registration_confirmation(@user).deliver
				ip = request.remote_ip
				MixpanelTrackJob.new.async.perform(@user.id,'Created Account',{
					"$method"=> "Facebook"
					},ip)
				MixpanelPeopleJob.new.async.perform(@user.id,{
				 	"$name"=> @user.name,
			 		"$email"=> @user.email,
				 	"$phone"=> @user.phone

				},request.remote_ip)
			else
				flash[:alert] = "Oops! Couldn't create an account!"
				render "new_signup",:layout => "application_new"
			end
		else #If user exists, but isn't authed
			@user = User.find_by_email(omniauth['info']['email'])
			@user.fbaccesstoken = omniauth['credentials']['token']
			@user.provider = omniauth['provider']
			@user.uid = omniauth['uid']
			if(@user.save)
				session[:user_id] = @user.id
				flash[:notice] = "Welcome Back!"
				redirect_to(dashboard_path)
			else
				flash[:alert] = "Oops! Couldn't Create account!"
				render "new_signup",:layout => "application_new"
			end
		end
	end

	def edit
		return if require_login
		@user = current_user
		render layout: "application_inside"
	end

	def changepassword
		return if require_login
		@user = current_user
		render layout: "application_inside"
	end

	def updatepassword
		@user = current_user

		if not @user.check_password(params[:password])
			flash[:alert]= 'Your old password is wrong'
			render "changepassword", layout: 'application_inside' and return
		end

		if params[:new_password] != params[:new_password_confirmation]
			flash[:alert]="Passwords don't match"
			render 'changepassword', layout: 'application_inside' and return
		end

		if params[:new_password] == ''
			flash[:alert] = "Password can't be empty"
			render 'changepassword', layout: 'application_inside' and return
		end

		@user.password = params[:new_password]

		if @user.save
			flash[:notice] = "Details Updated."
			redirect_to dashboard_path
		else
			flash[:alert] = "Password change Failed. Try again"
			render 'changepassword', layout: 'application_inside'
		end
	end

	def forgotpassword
		if(current_user)
			redirect_to(dashboard_path)
		end
	end

	def resetpassword
		@user = User.find_by_email(params[:email])
		if @user
			@randompass = ('a'..'z').to_a.shuffle[0, 5].join
			@user.password = @randompass
			@user.save
			UserMailer.password_reset(@user, @randompass).deliver
		end
		flash[:notice] = "Check your email for further instructions. It might take 2-3 minutes for the email to reach you."
		redirect_to(login_path)
	end

	# def destroy
	# 	current_user.destroy if current_user
	# 	flash[:notice] = "Account Deleted"
	# 	redirect_to(login_path)
	# end

	def update
		@user = current_user
		@user.name = params[:name]
		@user.phone = params[:phone]
		@user.phone_operator = params[:phone_operator]
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "Details Updated."
			redirect_to(dashboard_path)
		else
			flash[:alert] = "Unable to update profile"
			render "edit", layout: "application_inside"
		end
	end

	def olddashboard # User Dashboard
		require_login
		@current_user = current_user
		@user = @current_user
		if @user
			MixpanelPeopleJob.new.async.perform(@user.id,{
				"$name"=> @user.name,
				"$email"=> @user.email,
				"$phone"=> @user.phone,
				"Total Orders" => @user.orderscount,
				"Pending Orders" => @user.pendingorderscount,
				"Successful Orders" => @user.successfulorderscount,
				"Failed Orders" => @user.failedorderscount,
				"$created"=> @user.created_at,

			},request.remote_ip)
			MixpanelTrackJob.new.async.perform(@user.id,'Viewed Dashboard',{},request.remote_ip)
		end
	end

	def dashboard
		return if require_login
		@current_user = current_user
		@user = @current_user
		if @user
			MixpanelPeopleJob.new.async.perform(@user.id,{
				"$name" => @user.name,
				"$email" => @user.email,
				"$phone" => @user.phone,
				"Total Orders" => @user.orderscount,
				"Pending Orders" => @user.pendingorderscount,
				"Successful Orders" => @user.successfulorderscount,
				"Failed Orders" => @user.failedorderscount,
				"$created" => @user.created_at,
			}, request.remote_ip)
			MixpanelTrackJob.new.async.perform(@user.id, 'Viewed Dashboard', {}, request.remote_ip)
		end
		@orders = @current_user.orders.order(:created_at).reverse
		render :layout => "application_inside"
	end
end
