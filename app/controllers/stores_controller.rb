class StoresController < ApplicationController
	layout "application_inside"
	def index # /stores
		#@stores = Store.all
		@categories = Category.all
	end

	def show
		@store = Store.find_by_slug(params[:slug])
		unless @store
			flash[:alert] = "The store #{params[:slug]} isn't a valid store!"
			redirect_to(stores_path)	
		end
	end
	def visited
		@store = Store.find_by_slug(params[:slug])
		unless @store
			flash[:alert] = "The store #{params[:slug]} isn't a valid store!"
			redirect_to(stores_path)	
		end
	end

	def visitstore		
		@store = Store.find_by_slug(params[:slug])
		if @store.slug == "amazon"
			redirect_to(newamazon_path)
		end
		unless @store
			flash[:alert] = "The store #{params[:slug]} isn't a valid store!"
			redirect_to(stores_path)	
		end

		tracker = Tracking.new
		tracker.save
		finalurl = @store.redirecturl(tracker.id)
		@redirecturl = finalurl[:redirecturl]						
		tracker.url = @store.tracker_storeurl
		tracker.store = finalurl[:store]
		tracker.finalurl = finalurl[:redirecturl]		
		tracker.user = current_user
		tracker.save				
	end
end
