include ERB::Util

class OrdersController < ApplicationController
	# def old_edit
	# 	return if require_login
	# 	if Order.where(:id => params[:id]).blank?
	# 		flash[:alert] = "Order doesn't exist"
	# 		redirect_to(orders_path)
	# 	else
	# 		@order = Order.find(params[:id])
	# 		if (@order.status == 0 && @order.user == current_user)
	# 			@order = Order.find(params[:id])
	# 		else
	# 			flash[:alert] = "You can't edit orders that have been confirmed."
	# 			redirect_to(orders_path)
	# 		end
	# 	end
	# end

	# def old_update
	# 	@order = Order.find(params[:id])
	# 	if @order.shopname == 1
	# 		@order.orderid = params[:orderid]
	# 		@order.productname = params[:productname]
	# 		@order.emailused = params[:emailused]
	# 	else
	# 		@order.productname = params[:productname]
	# 	end
	# 	if @order.save
	# 		flash[:Notice] = "Order Details Updated."
	# 		redirect_to(orders_path)
	# 	else
	# 		render "edit"
	# 	end
	# end

	def update_desc
		@order = Order.find(params[:id])
		@order.update_column(:productname, html_escape(params[:desc]))
		render :json => {"desc" => @order.productname}
	end

	def destroy
		@order = Order.find(params[:id])
		if @order.status != 2
			@order.destroy
		end
		render :json => {}
	end

	def newamazon
		if(!current_user)
			flash[:alert] = "You aren't signed in. Log in below, or create an acount."
			redirect_to(new_login_path)
		end
		@order = Order.new
	end

	def createamazon # Create Order
		@current_user = current_user
		@order = Order.new
		@order.user_id = @current_user.id
		amazon_store = Store.where(:name => "Amazon").first
		@order.store = amazon_store
		@order.orderid = params[:orderid]
		@order.ordertotal = params[:ordertotal]
		@order.emailused = params[:emailused]
		if(params[:productname])
			@order.productname = params[:productname]
		end
		@order.status = 0
		@order.amount = 0
		if(@order.save)
			flash[:alert]=nil
			flash[:notice]="Your order will be confirmed within 1 week."
			redirect_to dashboard_path
			#UserMailer.order_creation(@current_user,@order).deliver
			MixpanelTrackJob.new.async.perform(@order.user.id,'Created Order',{
				'Store'=> "Amazon"
			},request.remote_ip)
		else
			flash[:alert] = "Not able to create order."
			render "newamazonretry"
		end
	end

	# def old_show #Order Details
	# 	if(!current_user)
	# 		flash[:alert] = "You aren't signed in. Log in below, or create an acount."
	# 		redirect_to(new_login_path)
	# 	else
	# 		@order = current_user.orders.where(id: params[:id])
	# 		if @order.empty?
	# 			flash[:alert] = "Order doesn't exist."
	# 			redirect_to(dashboard_path)
	# 		else
	# 			@order = @order.first
	# 			MixpanelTrackJob.new.async.perform(current_user.id,'Viewed Order',{
	# 				"Order ID" => @order.id
	# 			},request.remote_ip)
	# 		end
	# 	end
	# end

	# def old_index #Orders
	# 	require_login
	# 	if(current_user)
	# 		@current_user = current_user
	# 		@orders = @current_user.orders
	# 	end

	# end

end
