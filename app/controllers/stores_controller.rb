class StoresController < ApplicationController
	layout "application_inside"
	def index # /stores
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
		unless @store
			flash[:alert] = "The store #{params[:slug]} isn't a valid store!"
			redirect_to(stores_path) and return
		end

		if @store.slug == "amazon"
			redirect_to(newamazon_path) and return
		end

		tracker = Tracking.create(url: @store.tracker_storeurl, user: current_user)
		@redirecturl = tracker.finalurl
	end
end
