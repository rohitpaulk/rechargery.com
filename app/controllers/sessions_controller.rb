class SessionsController < ApplicationController
	def create
		@user = User.find_by_email(params[:email])
		if @user and @user.check_password(params[:password])
			session[:user_id] = @user.id
			flash[:notice] = "Hi, #{@user.name} !"
			if params[:return_to].to_s != ''
				redirect_to(params[:return_to])
			else
				redirect_to(dashboard_path)
			end
		  #MixpanelTrackJob.new.async.perform(@user.id,'Logged in',{},request.remote_ip)
		 	@user.last_login = DateTime.now
		 	@user.save
		else
			flash.now.alert = "Wrong Login Credentials"
			render "users/new_login", :layout => "application_new"
		end
	end

	def logoutpage
		@current_user = current_user
	end

	def destroy
		session[:user_id]=nil
		redirect_to "/"
	end
end
