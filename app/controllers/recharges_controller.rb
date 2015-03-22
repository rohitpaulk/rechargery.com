class RechargesController < ApplicationController
	# def new
	# 	require_login
	# 	@order = Order.find(params[:orderid])
	# 	@phone = ""
	# 	if current_user
	# 		@phone = current_user.phone
	# 	end
	# end

	# def create
	# 	@current_user = current_user
	# 	@order = Order.find(params[:orderid])
	# 	@recharge = Recharge.new
	# 	@recharge.order_id= @order.id
	# 	@recharge.phonenumber = params[:phonenumber]
	# 	@recharge.circlecode = 1 # Default
	# 	@recharge.operatorcode = params[:phone_operator]
	# 	@recharge.status = 0 # Pending
	# 	if(@recharge.save)
	# 		flash[:alert]=nil
	# 		flash[:notice]="Order Created"
	# 		redirect_to(dashboard_path)
	# 	else
	# 		flash[:alert] = "Error in recharge details."
	# 		render "new"
	# 	end
	# end

	# def edit
	# 	if Recharge.where(:id => params[:id]).blank?
	# 		flash[:alert] = "Order doesn't exist"
	# 		redirect_to(orders_path)
	# 	else
	# 		@recharge = Recharge.find(params[:id])

	# 		if (@recharge.status == 0 && @recharge.order.user == current_user)
	# 			@recharge = Recharge.find(params[:id])
	# 		else
	# 			flash[:alert] = "You can't edit orders that have been confirmed."
	# 			redirect_to(orders_path)
	# 		end
	# 	end
	# end

	# def update
	# 	@recharge = Recharge.find(params[:id])
	# 	@recharge.phonenumber = params[:phonenumber]
	# 	@recharge.circlecode = 1
	# 	@recharge.operatorcode = params[:phone_operator]
	# 	if @recharge.save
	# 		flash[:Notice] = "Recharge Details Updated."
	# 		redirect_to url_for({:controller => "recharges",:action => "show", :id => @recharge.id })
	# 	else
	# 		render "edit"
	# 	end
	# end

	# def show
	# 	if(!current_user)
	# 		flash[:alert] = "You aren't signed in. Log in below, or create an acount."
	# 		redirect_to(login_path)
	# 	else
	# 		if !(Recharge.where(:id => params[:id]).empty?)
	# 			@recharge = Recharge.find(params[:id])
	# 			@order = @recharge.order
	# 		else
	# 			redirect_to(orders_path)
	# 		end
	# 	end
	# end
end
